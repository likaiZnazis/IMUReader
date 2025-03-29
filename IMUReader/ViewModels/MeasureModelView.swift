import Foundation
import CoreMotion

class SquatMeasurement: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var isMeasuring = false
    // Later for segmentation
//    @Published var currentSquatSet = SquatSet()
    var fileStorageManager: FileStorageManager
    @Published var currentRep: SquatRep? = nil
    private var timer: Timer?
    
    init(){
        self.fileStorageManager = FileStorageManager()
        fileStorageManager.createCSVFile()
    }
    
    func startTracking() {
        
        guard motionManager.isDeviceMotionAvailable else { return }
        isMeasuring = true
        motionManager.deviceMotionUpdateInterval = 0.02
        currentRep = SquatRep(
            squatForm: .none,
            time: Date(),
            accelerometer: Accelerometer(x: 0, y: 0, z: 0),
            gyroscope: Gyroscope(x: 0, y: 0, z: 0),
            magnetometer: Magnetometer(x: 0, y: 0, z: 0),
            rotation: RotationAngles(pitch: 0, yaw: 0, roll: 0)
        )
                
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion else {
                if let error = error {
                    print("Error getting motion data: \(error.localizedDescription)")
                }
                return
            }
                    
            // Capture the current time and sensor data
            if var rep = self.currentRep {
                let timestamp = motion.timestamp
                let time = Date(timeIntervalSince1970: timestamp)
                        
                // Store the most recent sensor data
                rep.accelerometer = Accelerometer(x: motion.userAcceleration.x,
                                                    y: motion.userAcceleration.y,
                                                    z: motion.userAcceleration.z)
                        
                rep.gyroscope = Gyroscope(x: motion.rotationRate.x,
                                            y: motion.rotationRate.y,
                                            z: motion.rotationRate.z)
                        
                rep.magnetometer = Magnetometer(x: motion.magneticField.field.x,
                                                y: motion.magneticField.field.y,
                                                z: motion.magneticField.field.z)
                        
                rep.rotation = RotationAngles(pitch: motion.attitude.pitch,
                                                yaw: motion.attitude.yaw,
                                                roll: motion.attitude.roll)

                // Update the rep with new time
                rep.time = time
                
                self.currentRep = rep
                fileStorageManager.appendToCSV(squatRep: rep)
            }
        }
    }
    
    func stopTracking() {
        isMeasuring = false
    }
    
//    func saveSet() {
//        // Logic to save or export the set
//        print("Squat Set Saved: \(currentSquatSet)")
//        currentSquatSet = SquatSet()
//    }
}
