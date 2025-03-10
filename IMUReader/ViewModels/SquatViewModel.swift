//
//  SquatViewModel.swift
//  IMUReader
//
//  Created by Martins Vitols on 20/02/2025.
//

import SwiftUI

class SquatViewModel: ObservableObject {
    @Published var squatSets: [SquatSet] = []
    
    func saveSquatRep(measurement: SquatMeasurement) {
        let newRep = SquatRep(
            time: Date(),
            sampleNumber: measurement.sampleNumber,
            form: .none,
            depth: measurement.currentDepth,
            rotation: measurement.currentRotation
        )
        
        if var lastSet = squatSets.last {
            lastSet.SquatReps.append(newRep)
        } else {
            let newSet = SquatSet(date: Date(), SquatReps: [newRep])
            squatSets.append(newSet)
        }
    }
}

