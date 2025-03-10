//
//  SquatObject.swift
//  IMUReader
//
//  Created by Martins Vitols on 20/02/2025.
//
import Foundation

struct SquatSet: Identifiable {
    var id: UUID = UUID()
    var date: Date = Date()
    var SquatReps: [SquatRep] = []
}

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

struct SquatRep: Identifiable {
    var id: UUID = UUID()
    var time: Date = Date()
    var sampleNumber: Int
    var form: SquatForm
    var suggestions: [String] = []
    var depth: Double = 0.0
    var rotation: RotationAngles
}
