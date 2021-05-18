//
//  LocationListItem.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI

struct LocationRow: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    var location: LocationData
    
    @State private var dragged = CGFloat.zero
    @State private var accumulated = CGFloat.zero

    @Binding public var programmaticAddTransition: String
    
    let deleteThreshold = CGFloat(100)
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { gesture in
                    self.dragged += gesture.translation.width
                }
                .onEnded { gesture in
                    if abs(self.dragged) > deleteThreshold {
                        CoreDataHelper.deleteLocation(viewContext: managedObjectContext, location: location)
                    } else {
                        self.dragged = .zero
                    }
                }
        }

    var body: some View {
        NavigationLink(destination: LocationDetails(locationData: location, programmaticAddTransition: $programmaticAddTransition),
                       isActive:
                        Binding(
                            get: {
                                return programmaticAddTransition.count > 0 && (location.ident != nil) && programmaticAddTransition == location.ident!
                            },
                            set: { newValue in
                                if newValue || programmaticAddTransition.count > 0 {
                                    self.programmaticAddTransition = location.ident!
                                }
                            }
                        )) {
            // TODO: Fix bug where children of navigation link aren't clickable.
            HStack {
                Image(systemName: "cloud").resizable().accentColor(.accentColor)
                    .frame(width: 30, height: 30)
                    .padding(5).foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(location.ident ?? "")
                        .font(.title)
                    HStack {
                        Text(String(format: "Last updated: %@", getTimeSinceDate(date: location.lastViewed!)))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 10)
            }
            .foregroundColor(.black)
        }
        .gesture(drag)
        .frame(maxWidth: .infinity)
        .offset(x: self.dragged)
        .padding(5)
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        return LocationRow(location: PersistenceController.getSampleLocation(), programmaticAddTransition: .constant("")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
