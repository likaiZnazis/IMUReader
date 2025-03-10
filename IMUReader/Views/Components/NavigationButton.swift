//
//  NavigationButton.swift
//  IMUReader
//
//  Created by Martins Vitols on 21/02/2025.
//
import SwiftUI

struct BottomButton: View {
    var icon: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            VStack{
                Image(systemName: icon)
                Text(text)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth:.infinity)
        }
    }
}

struct BackButton: View {
    @EnvironmentObject var mainState: UIModelView
    
    var action: () -> Void
    //The button should be disabled if its home
    var body: some View {
        if navigationHistory.isEmpty {
            //Disabled button
            Button(action: {}){
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .opacity(0.2)
            }
        }else{
            //Enabled button
            Button(action: action){
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            }
        }
    }
}
