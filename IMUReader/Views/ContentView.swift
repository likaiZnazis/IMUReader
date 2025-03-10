//
//  ContentView.swift
//  IMUReader
//
//  Created by Martins Vitols on 22/01/2025.
//
import SwiftUI
import CoreMotion

struct ContentView: View {
    //Here we pass the state from modal
    @EnvironmentObject var mainState: UIModelView
    
    var body: some View {
        
        VStack {
            //Header top
            HStack{
                Button(action:{
                    print("Change view to settings")
                }){
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                }
                .padding(.all, 20)
                Spacer()
                Button(action:{
                    print(navigationHistory)
                }){
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                }
                .padding(.all, 20)
            }
            .background(.black)
            .cornerRadius(12)
            .padding()
                
            //Main section
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    BackButton(action: {mainState.goBack()})
                    Text(mainState.headingText())
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                //Main body where the content changes
                mainState.changeMainContent()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .cornerRadius(12)
                .padding()
            //Bottom buttons
            HStack{
                BottomButton(icon: "doc.text", text: "Measure"){
                    mainState.currentHeading = .createSet
                }
                BottomButton(icon: "house.fill", text: "Home"){
                    mainState.currentHeading = .home
                }
                BottomButton(icon: "play.fill", text: "Classify"){
//                    mainState.currentHeading = .classify
                    print("Classify will come later")
                }
            }
            .background(.black)
            .cornerRadius(12)
            .padding()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    ContentView()
}
