//
//  MeasuringSection.swift
//  IMUReader
//
//  Created by Martins Vitols on 19/02/2025.
//

import SwiftUI

//Starting section
struct CreateNewSet: View {
    @EnvironmentObject var mainState: UIModelView

    var body: some View{
        VStack{
                Button(action: {
                    mainState.navigate(to: .instructions)
                }){
                    HStack {
                        Image(systemName: "plus")
                        Text("Create a new Set")
                            .font(.title2)
                    }
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding(.top, 5)
                Spacer()
        }
    }
}
