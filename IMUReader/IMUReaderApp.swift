
import SwiftUI

@main
struct IMUReader: App {
    @StateObject private var mainState = UIModelView()
    @StateObject private var squatMeasurementState = SquatMeasurement()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(mainState)
                .environmentObject(squatMeasurementState)
        }
    }
}
