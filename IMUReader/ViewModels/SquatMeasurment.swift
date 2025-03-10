//
//  SquatMeasurment.swift
//  IMUReader
//
//  Created by Martins Vitols on 20/02/2025.
//
import Foundation
import CoreMotion

class SquatMeasurement: ObservableObject {
    private var motionManager = CMMotionManager()
    
    @Published var currentDepth: Double = 0.0
    @Published var currentRotation = RotationAngles(pitch: 0, yaw: 0, roll: 0)
    @Published var isMeasuring = false
    var sampleNumber: Int = 0

    func startTracking() {
        guard motionManager.isDeviceMotionAvailable else { return }
        isMeasuring = true
        motionManager.deviceMotionUpdateInterval = 0.05 //

        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
            
            self.sampleNumber += 1
            self.currentDepth = motion.userAcceleration.z
            self.currentRotation = RotationAngles(
                pitch: motion.attitude.pitch,
                yaw: motion.attitude.yaw,
                roll: motion.attitude.roll
            )
        }
    }

    func stopTracking() {
        isMeasuring = false
        motionManager.stopDeviceMotionUpdates()
    }
}
