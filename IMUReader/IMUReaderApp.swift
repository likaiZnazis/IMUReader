//
//  IMUReaderApp.swift
//  IMUReader
//
//  Created by Martins Vitols on 22/01/2025.
//

import SwiftUI

@main
struct IMUReader: App {
    @StateObject private var mainState = UIModelView()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainState)
        }
    }
}
