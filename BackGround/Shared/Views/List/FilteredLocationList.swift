//
//  FilteredLocationList.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI

struct FilteredLocationList: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    var fetchRequest: FetchRequest<LocationData>

    @Binding var programmaticAddTransition: String
    
    let oneHourInSeconds = 60 * 60.0
    
    init(filterPredicate: String, transition: Binding<String>) {
        self._programmaticAddTransition = transition
        fetchRequest = FetchRequest<LocationData>(entity: LocationData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LocationData.lastViewed, ascending: false)], predicate: NSPredicate(format: filterPredicate))
    }

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { location in
            LocationRow(location: location, programmaticAddTransition: $programmaticAddTransition)
        }
        .listStyle(InsetListStyle())
        .listRowInsets(EdgeInsets())
        .onAppear(perform: {
            // Try to find reports for the location.
            for location in fetchRequest.wrappedValue {
                if abs(location.lastViewed!.timeIntervalSince(Date())) > oneHourInSeconds {
                    requestWeatherReport(ident: location.ident!, viewContext: managedObjectContext)
                }
            }
        })
    }
}

struct FilteredLocationList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredLocationList(filterPredicate: "isFavorite == YES", transition: .constant("")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
