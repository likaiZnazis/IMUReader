import Foundation
import CoreMotion

class SquatMeasurement: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var isMeasuring = false
    @Published var currentSquatSet = SquatSet()
    
    @Published var currentRep: SquatRep? = nil
    private var timer: Timer?
    
    func startTracking() {
        guard motionManager.isDeviceMotionAvailable else { return }
        isMeasuring = true
        motionManager.deviceMotionUpdateInterval = 0.02
        currentRep = SquatRep()
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion, var rep = self.currentRep else { return }
            
            // Capture timestamps
            rep.time.append(Date())
            
            // Store sensor data
            rep.accelerometer.append(Accelerometer(
                x: motion.userAcceleration.x,
                y: motion.userAcceleration.y,
                z: motion.userAcceleration.z
            ))
            
            rep.gyroscope.append(Gyroscope(
                x: motion.rotationRate.x,
                y: motion.rotationRate.y,
                z: motion.rotationRate.z
            ))
            
            rep.magnetometer.append(Magnetometer(
                x: motion.magneticField.field.x,
                y: motion.magneticField.field.y,
                z: motion.magneticField.field.z
            ))
            
            rep.rotation.append(RotationAngles(
                pitch: motion.attitude.pitch,
                yaw: motion.attitude.yaw,
                roll: motion.attitude.roll
            ))
            
            self.currentRep = rep
        }
    }
    
    func stopTracking() {
        isMeasuring = false
    }
    
    func saveSet() {
        // Logic to save or export the set
        print("Squat Set Saved: \(currentSquatSet)")
        currentSquatSet = SquatSet()
    }
}
