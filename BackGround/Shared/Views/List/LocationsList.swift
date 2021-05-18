//
//  LocationsView.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/15/21.
//

import SwiftUI

struct LocationsList: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var selectedLocationType: LocationType = LocationType.Favorites

    @Binding public var programmaticAddTransition: String
    
    enum LocationType: String, CaseIterable {
        case Favorites
        case History
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            HStack(alignment: .top, spacing: 0, content: {
                Picker("Location Type", selection: $selectedLocationType) {
                    ForEach(LocationType.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, -5)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            })
            FilteredLocationList(
                filterPredicate:
                    String(format: "isFavorite == %d OR 1 == %d", selectedLocationType == LocationType.Favorites, selectedLocationType != LocationType.Favorites),
                transition: $programmaticAddTransition)
                .listStyle(InsetListStyle())
                .listRowInsets(EdgeInsets())
                .padding(.top, 8)
        })
        Text("Swipe locations above to delete").font(.subheadline).foregroundColor(.red)
        Text("Click outside of text to view").font(.subheadline).foregroundColor(.red)
            .fontWeight(.bold).padding(.bottom)
    }
}

struct LocationsList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
