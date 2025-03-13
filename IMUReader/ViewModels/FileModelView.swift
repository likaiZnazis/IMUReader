// Read, write to a file. Also send a file
// Reading will be used later for squat segmentation
import SwiftUI

//Creates a csv file
class FileStorageManager{
    func createCSVFile() {
        let fileName = "IMUData.csv" //Give a simple file name
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            csvFileURL = fileURL
                
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                let headers = "Time,AccX,AccY,AccZ,GyroX,GyroY,GyroZ,Pitch,Roll,Yaw\n"
                try? headers.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        }
    }

    func appendToCSV(squatRep: SquatRep) {
        // Ensure csvFileURL points to the document directory
        guard let fileURL = csvFileURL else {
            print("Error: CSV file URL is not defined.")
            return
        }
        
        // Ensure the file exists, if not, create it
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // If the file doesn't exist, create it and add the header
            let header = "timestamp,acc_x,acc_y,acc_z,gyro_x,gyro_y,gyro_z,pitch,roll,yaw\n"
            try? header.write(to: fileURL, atomically: true, encoding: .utf8)
        }
        
        // Prepare the data to append: timestamp, accelerometer, gyroscope, and rotation
        let timestamp = Date().timeIntervalSince1970
        let newLine = String(format: "%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.2f,%.2f,%.2f\n",
                            timestamp,
                            squatRep.accelerometer.x, squatRep.accelerometer.y, squatRep.accelerometer.z,
                            squatRep.gyroscope.x, squatRep.gyroscope.y, squatRep.gyroscope.z,
                            squatRep.rotation.pitch, squatRep.rotation.roll, squatRep.rotation.yaw)
        
        // Append the data to the file
        do {
            if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                fileHandle.seekToEndOfFile()
                if let data = newLine.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            } else {
                // If FileHandle fails, write the data directly
                try newLine.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        } catch {
            print("Error appending data to CSV: \(error.localizedDescription)")
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
