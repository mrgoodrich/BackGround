//
//  CoreDataHelper.swift
//  BackGround (iOS)
//
//  Created by Matt Goodrich on 5/16/21.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataHelper {
    static func addLocation(viewContext: NSManagedObjectContext, ident: String) {
        let newLocation = LocationData(context: viewContext)
        newLocation.ident = ident.lowercased()
        newLocation.isFavorite = true
        newLocation.lastViewed = Date()
        PersistenceController.shared.save()
    }
    
    static func toggleFavorite(viewContext: NSManagedObjectContext, location: LocationData) {
        location.isFavorite.toggle()
        PersistenceController.shared.save()
    }
    
    static func cacheReport(viewContext: NSManagedObjectContext, report: Report) {
        transformReportToData(viewContext: viewContext, report: report)
        PersistenceController.shared.save()
    }
    
    static func deleteLocation(viewContext: NSManagedObjectContext, location: LocationData) {
        viewContext.delete(location)
        PersistenceController.shared.save()
    }
    
    static func pruneReportCache(viewContext: NSManagedObjectContext, reports: FetchedResults<ReportData>) {
        for report in reports {
            if abs(report.dateIssued!.timeIntervalSince(Date())) > 60 * 60 {
                viewContext.delete(report)
            }
        }
        do { try viewContext.save() }
        catch { print("failed to delete old cache values") }
    }
}
