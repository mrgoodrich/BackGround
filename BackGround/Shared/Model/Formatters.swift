//
//  Formatters.swift
//  BackGround (iOS)
//
//  Created by Matt Goodrich on 5/17/21.
//

import Foundation

func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: date)
}

func getTimeSinceDate(date: Date) -> String {
    let diff = Calendar.current.dateComponents([.hour, .minute, .second], from: date, to: Date())
    let hrs = diff.hour!
    let min = diff.minute!
    let sec = diff.second!
    
    if (hrs > 0) {
        return String(format: "%d hrs", hrs)
    } else if (min > 0) {
        return String(format: "%d mins", min)
    } else if (sec > 0) {
        return String(format: "%d sec", sec)
    }
    return String("now")
}
