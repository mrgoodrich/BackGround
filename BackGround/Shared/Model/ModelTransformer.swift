//
//  ModelTransformer.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/16/21.
//

import Foundation
import CoreData

// Returns the report structure to use in Core Data.
func transformReportToData(viewContext: NSManagedObjectContext, report: Report) -> ReportData {
    let reportData = ReportData(context: viewContext)
    reportData.ident = report.report.conditions.ident
    reportData.dateIssued = report.report.conditions.dateIssued
    reportData.lat = Double(round(1000*report.report.conditions.lat)/1000)
    reportData.lon = Double(round(1000*report.report.conditions.lon)/1000)
    reportData.text = report.report.conditions.text
    reportData.elevation = Int16(report.report.conditions.elevationFt)
    reportData.tempC = Int16(report.report.conditions.tempC)
    reportData.dewpointC = Int16(report.report.conditions.dewpointC)
    reportData.pressureHg = Double(report.report.conditions.pressureHg) as? NSDecimalNumber
    reportData.relativeHumidity = Int16(report.report.conditions.relativeHumidity)
    reportData.flightRules = report.report.conditions.flightRules
    if report.report.forecast != nil {
        reportData.forecastText = report.report.forecast?.text
    }
    
    return reportData
}

// Returns the report structure received from the endpoint and used in UI.
func transformReportFromData(data: ReportData) -> Report {
    let conditions = Report.Conditions(text: "test", ident: "test",
           dateIssued: Date(),
           lat: 1.0,
           lon: 1.0,
           elevationFt: 1,
           tempC: 1,
           dewpointC: 1,
           pressureHg: 2.0,
           relativeHumidity: 1,
           flightRules: "vfr",
           cloudLayers: [Report.Conditions.CloudLayer(
                            coverage: "bkn",
            altitudeFt: 2,
            ceiling: false
           )],
           cloudLayersV2: [Report.Conditions.CloudLayer(
            coverage: "bkn",
            altitudeFt: 2,
            ceiling: false
           )],
           weather: ["test"],
           visibility: Report.Conditions.Visibility(
            distanceSm: 2.0, prevailingVisSm: 2.1
           ),
           wind: Report.Conditions.Wind(
            speedKts: 2.0, direction: 3, from: 3, variable: false
           ))
    let forecast = Report.Forecast(text: "test")
    return Report(report: Report.ReportInner(conditions: conditions, forecast: forecast))
}

// Returns the location structure to use in Core Data.
func transformLocationToData(viewContext: NSManagedObjectContext, location: Location) -> LocationData {
    let locationData = LocationData(context: viewContext)
    locationData.ident = location.ident
    locationData.isFavorite = location.isFavorite
    locationData.lastViewed = location.lastViewed
    return locationData
}

// Returns the location structure received from the endpoint and used in UI.
func transformLocationFromData(data: LocationData) -> Location {
    return Location(ident: data.ident!, isFavorite: data.isFavorite, lastViewed: data.lastViewed!)
}
