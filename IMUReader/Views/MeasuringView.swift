 
import SwiftUI
import CoreMotion

struct MeasuringView: View {
    var fileStorage: FileStorageManager
    @EnvironmentObject var squatMeasurement: SquatMeasurement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Pitch: \(squatMeasurement.currentRep?.rotation.pitch ?? 0 , specifier: "%.2f")")
            Text("Roll: \(squatMeasurement.currentRep?.rotation.roll ?? 0, specifier: "%.2f")")
            Text("Yaw: \(squatMeasurement.currentRep?.rotation.yaw ?? 0, specifier: "%.2f")")

            Spacer()
            HStack {
                Button(squatMeasurement.isMeasuring ? "Stop" : "Start") {
                    squatMeasurement.isMeasuring ? squatMeasurement.stopTracking() : squatMeasurement.startTracking()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(squatMeasurement.isMeasuring ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
                Button("Save Set") {
                    fileStorage.exportCSV()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
