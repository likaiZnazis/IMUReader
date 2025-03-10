//
//  ShowInstructions.swift
//  IMUReader
//
//  Created by Martins Vitols on 19/02/2025.
//
import SwiftUI

struct ShowInstructions: View {
    
    private let instructions = ["Before you press the START button. Read instructions!", "Place your phone inside your right pocket", "Place the barbell on your back", "After 10 seconds a vibration will happen. Start squatting", "A seond vibration will happen. Stop squating", "Do 11 reps. 1st one is for calibration"]
    
    var body: some View {
        VStack{
            List (instructions.enumerated().map {$0}, id: \.1){index, item in
                HStack
                {
                    Text("\(index + 1).")
                        .bold()
                    Text(item)
                    Spacer()
                }
                .listRowBackground(Color.gray)
            }
            
            .multilineTextAlignment(.leading)
            .background(.black.opacity(0.4))
            .scrollContentBackground(.hidden)
            Button(action: {
                print("Starting to measure")
            }){
                HStack{
                    Text("START")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
    }
}
