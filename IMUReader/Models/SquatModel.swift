
import Foundation

//struct SquatSet: Identifiable {
//    var id: UUID = UUID()
//    var date: Date = Date()
//    var SquatReps: [SquatRep] = []
//}

enum SquatForm{
    case good
    case bad
    case none
}

struct RotationAngles{
    var pitch: Double
    var yaw: Double
    var roll: Double
}

struct Accelerometer{
    var x: Double
    var y: Double
    var z: Double
}

struct Gyroscope{
    var x: Double
    var y: Double
    var z: Double
}

struct Magnetometer{
    var x: Double
    var y: Double
    var z: Double
}

//struct SquatRep: Identifiable {
//    var id: UUID = UUID()
//    var squatForm: SquatForm = .none
//    var time: [Date] = [Date()]
//    var accelerometer: [Accelerometer] = []
//    var gyroscope: [Gyroscope] = []
//    var magnetometer: [Magnetometer] = []
//    var rotation: [RotationAngles] = []
//}

//For now lets have a simple squat rep.
//Dont know how to segment this data for now this will do
struct SquatRep {
//    var id: UUID = UUID()
    var squatForm: SquatForm = .none
    var time: Date = Date()
    var accelerometer: Accelerometer
    var gyroscope: Gyroscope
    var magnetometer: Magnetometer
    var rotation: RotationAngles
}
