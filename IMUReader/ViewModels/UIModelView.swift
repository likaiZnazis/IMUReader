//
//  UIModelView.swift
//  IMUReader
//
//  Created by Martins Vitols on 21/02/2025.
//
//  Handles the UI logic

import UIKit
import SwiftUI

class UIModelView: ObservableObject{
    //Current heading that will be displayed based on what page content is displayed
    @Published var currentHeading: HeadingType = .home
    
    //Changes the heading text based on what type of page is displayed
    func headingText() -> String {
        switch currentHeading {
            case .home: return "About the application"
            case .createSet: return "Lets start measuring your squats!"
            case .instructions: return "Before we start!"
            case .startMeasuring: return "Hope I'm inside your pocket"
        }
    }
    
    //Goes to the clicked page, argument page is the page that will be displayed
    func navigate(to page: HeadingType) {
        if currentHeading != page{
            navigationHistory.append(currentHeading) // Save current page before navigating
        }
        currentHeading = page
    }
    
    //Changes the main content based on heading
    func changeMainContent() -> AnyView{
        switch currentHeading {
        case .home:
            return AnyView(HomeView())
        case .createSet:
            return AnyView(CreateNewSet())
        case .instructions:
            return AnyView(ShowInstructions())
        default: return AnyView(Text("None"))
        }
    }
    
    // Navigates to the previous page
    func goBack() {
        if let lastPage = navigationHistory.popLast() {
            currentHeading = lastPage
        }
    }
}
