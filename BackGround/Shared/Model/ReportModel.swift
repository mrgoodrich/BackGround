//
//  Location.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/15/21.
//

import Foundation
import SwiftUI

struct Location {
    var ident: String
    var isFavorite: Bool
    var lastViewed: Date
}
//
//struct Report: Codable {
//    var ident: String
//    var conditions: Conditions
//    var forecast: Forecast
//
//    struct Conditions: Codable {
//        var flightRules: String
//        var basicWeather: BasicWeather
//        var observation: Observation
//    }
//
//    struct Forecast: Codable {
//        var period: Period
//        var basicWeather: BasicWeather
//        var observation: Observation
//        var conditions: [BasicWeather]
//    }
//
//    // All
//    struct Observation: Codable {
//        var ident: String
//        var dateIssued: Date
//        var lat: Double
//        var lon: Double
//    }
//
//    struct CloudLayer: Codable {
//        var coverage: String
//        var altitudeFt: Int
//        var ceiling: Bool
//    }
//
//    struct Visibility: Codable {
//        var distanceSm: Int
//        var prevailingVisSm: Int
//    }
//
//    struct Wind: Codable {
//        var speedKts: Int
//        var direction: Int
//        var from: Int
//        var variable: Bool
//    }
//
//    struct Period: Codable {
//        var start: Date
//        var end: Date
//    }
//
//    // Forecast, observation
//    struct BasicWeather: Codable {
//        var text: String
//        var dewpoint: Int
//        var elevationFt: Int
//        var tempC: Int
//        var dewpointC: Int
//        var pressureHg: Double
//        var densityAltitudeFt: Int
//        var relativeHumidity: Int
//        var flightRules: String
//        var cloudLayers: [CloudLayer]
//        var weather: [String]
//        var visibility: Visibility
//        var wind: Wind
//    }
//}

// Structure received from JSON in local file or endpoint.
struct Report: Codable {
    var report: ReportInner
    
    struct ReportInner: Codable {
        var conditions: Conditions
        var forecast: Forecast?
    }
    
    struct Conditions: Codable {
        var text: String
        var ident: String
        var dateIssued: Date
        var lat: Double
        var lon: Double
        var elevationFt: Int
        var tempC: Int
        var dewpointC: Int
        var pressureHg: Double
        var relativeHumidity: Int
        var flightRules: String
        var cloudLayers: [CloudLayer]
        var cloudLayersV2: [CloudLayer]
        var weather: [String]
        var visibility: Visibility
        var wind: Wind
        
        struct CloudLayer: Codable {
            var coverage: String
            var altitudeFt: Int
            var ceiling: Bool
        }
        
        struct Visibility: Codable {
            var distanceSm: Double
            var prevailingVisSm: Double
        }
        
        struct Wind: Codable {
            var speedKts: Double
            var direction: Int
            var from: Int
            var variable: Bool
        }
    }
    
    struct Forecast: Codable {
        var text: String
//        var conditions: [Conditions]
    }
}
