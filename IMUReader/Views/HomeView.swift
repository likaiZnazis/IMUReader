//
//  HomeView.swift
//  IMUReader
//
//  Created by Martins Vitols on 21/02/2025.
//
//  This view is for giving intro about the application.
//  What the application is for, who made it

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack{
                Text("Squat dataset creation")
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Why I want to make this project:")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("To create a accurate classification for squats that is also conviniant for people to use in their training, a good dataset is needed. There are no real ways to create a personalized dataset without extra equipment and software. Also domain knowledge about data science is needed to create a good dataset.")
                    .font(.callout)
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
                    .padding()
                Text("")
            }
            .padding(.top, 5)
            .scrollDisabled(false)
            Spacer()
        }
    }
}
