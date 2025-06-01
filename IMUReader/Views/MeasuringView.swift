//
//  MeasuringView.swift
//  IMUReader
//
//  Created by Martins Vitols on 21/02/2025.
//
        
import SwiftUI
import CoreMotion

struct MeasuringView: View {
    @StateObject private var imuManager = IMUManager()
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("Accelerometer: \(imuManager.acceleration)")
                Text("Gyroscope: \(imuManager.gyroscope)")
                Text("Pitch: \(imuManager.pitch, specifier: "%.2f")")
                Text("Roll: \(imuManager.roll, specifier: "%.2f")")
                Text("Yaw: \(imuManager.yaw, specifier: "%.2f")")
                Spacer()
                HStack {
                    Button(imuManager.isMeasuring ? "Stop" : "Start") {
                        imuManager.toggleIMUUpdates()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(imuManager.isMeasuring ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    
                    Spacer()
                    Button("Export CSV") {
                        imuManager.exportCSV()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
}

class IMUManager: ObservableObject {
    private var motionManager = CMMotionManager()
    private let updateInterval = 1.0 / 50.0 // 50 Hz
    private var csvFileURL: URL?
    
    //Model
    @Published var isMeasuring = false
    @Published var acceleration: String = "X: 0.00, Y: 0.00, Z: 0.00"
    @Published var gyroscope: String = "X: 0.00, Y: 0.00, Z: 0.00"
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0
    
    init() {
        createCSVFile()
    }
    

    func toggleIMUUpdates() {
        if isMeasuring {
            stopIMUUpdates()
        } else {
            startIMUUpdates()
        }
        isMeasuring.toggle()
    }

    func startIMUUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = updateInterval
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }

                let acc = motion.userAcceleration
                self.acceleration = String(format: "X: %.2f, Y: %.2f, Z: %.2f", acc.x, acc.y, acc.z)

                let gyro = motion.rotationRate
                self.gyroscope = String(format: "X: %.2f, Y: %.2f, Z: %.2f", gyro.x, gyro.y, gyro.z)

                self.pitch = motion.attitude.pitch * (180.0 / .pi)
                self.roll = motion.attitude.roll * (180.0 / .pi)
                self.yaw = motion.attitude.yaw * (180.0 / .pi)

                self.appendToCSV(acc: acc, gyro: gyro, pitch: self.pitch, roll: self.roll, yaw: self.yaw)
            }
        }
    }
    func stopIMUUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }

    // MARK: - CSV File Handling
    private func createCSVFile() {
        let fileName = "IMUData.csv"

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)

            // Delete the existing file if it exists
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                    print("Deleted existing file before creating a new one.")
                } catch {
                    print("Failed to delete file: \(error)")
                }
            }

            csvFileURL = fileURL

            // Create a new file and add headers
            let headers = "Time,AccX,AccY,AccZ,GyroX,GyroY,GyroZ,Pitch,Roll,Yaw\n"
            do {
                try headers.write(to: fileURL, atomically: true, encoding: .utf8)
                print("CSV file created successfully.")
            } catch {
                print("Failed to create CSV file: \(error)")
            }
        }
    }

    private func appendToCSV(acc: CMAcceleration, gyro: CMRotationRate, pitch: Double, roll: Double, yaw: Double) {
        guard let fileURL = csvFileURL else { return }

        let timestamp = Date().timeIntervalSince1970
        let newLine = String(format: "%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n",
                             timestamp, acc.x, acc.y, acc.z, gyro.x, gyro.y, gyro.z, pitch, roll, yaw)

        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            if let data = newLine.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        }
    }

    func exportCSV() {
        guard let fileURL = csvFileURL else { return }

        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
}

