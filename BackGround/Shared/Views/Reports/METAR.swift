//
//  METAR.swift
//  BackGround (iOS)
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI

struct METAR: View {
    var report: ReportData
    
    var body: some View {
        VStack {
            VStack {
                HStack() {
                    Text(getTimeSinceDate(date: report.dateIssued!))
                    Text(report.text!).foregroundColor(.green).padding(5)
                }
            }.frame(maxWidth: .infinity)
            
            Text(String(format: "%d °C / %d °C",report.tempC, report.dewpointC))
            
            if (abs(report.tempC - report.dewpointC) <= 4) {
                Text("Cloud formation likely.")
            }
            
            Text(String(format: "Date Issued: %@", formatDate(date: report.dateIssued!))).padding(5)
            
//            VStack {
//                Text("Temp")
//                Text("Dewpoint")
//                Text("Pressure")
//                Text("Density Altitude")
//                Text("Relative Humidity")
//                Text("Flight Rules")
//                Text("Cloud Layers")
//                Text("Weather")
//                Text("Visibility")
//                Text("Wind")
//            }
        }
    }
}

struct METAR_Previews: PreviewProvider {
    static var previews: some View {
        METAR(report: PersistenceController.getSampleReport())
    }
}
