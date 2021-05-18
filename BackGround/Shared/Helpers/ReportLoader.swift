//
//  ReportLoader.swift
//  BackGround (iOS)
//
//  Created by Matt Goodrich on 5/16/21.
//

import Foundation
import CoreData

func requestWeatherReport(ident: String, viewContext: NSManagedObjectContext) {
    var request = URLRequest(url: URL(string: String(format: "%@%@", "https://qa.foreflight.com/weather/report/", ident))!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("1", forHTTPHeaderField: "ff-coding-exercise")
    request.httpMethod = "GET"

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            // Cache report.
            var report: Report
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                try report = decoder.decode(Report.self, from: data)
            } catch {
                print("Couldn't parse response:\n\(error)")
                return
            }
            CoreDataHelper.cacheReport(viewContext: viewContext, report: report)
        }
    }.resume()
}
