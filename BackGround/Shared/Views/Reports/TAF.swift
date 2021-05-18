//
//  TAF.swift
//  BackGround (iOS)
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI

struct TAF: View {
    var report: ReportData

    var body: some View {
        if report.forecastText != nil {
            VStack {
                VStack {
                    HStack() {
                        Text(getTimeSinceDate(date: report.dateIssued!))
                        Text(report.forecastText!).foregroundColor(.green).padding(5)
                    }
                }.frame(maxWidth: .infinity)            }
        } else {
            Text("Current location does not provide forecasts. Please consult nearby larger locations.")
        }
    }
}

struct TAF_Previews: PreviewProvider {
    static var previews: some View {
        TAF(report: PersistenceController.getSampleReport())
    }
}
