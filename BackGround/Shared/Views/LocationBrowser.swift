//
//  LocationBrowser.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI
import CoreData

struct LocationBrowser: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var locationToSearch: String = ""
    
    @Binding public var programmaticAddTransition: String
    
    var body: some View {
        Text("Search Locations")
            .font(.title)
        TextField("Enter Identifier", text: $locationToSearch)
            .multilineTextAlignment(.center)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(20)
        Button("Add Location") {
            CoreDataHelper.addLocation(viewContext: managedObjectContext, ident: locationToSearch)
            requestWeatherReport(ident: locationToSearch, viewContext: managedObjectContext)
            self.mode.wrappedValue.dismiss()
            programmaticAddTransition = locationToSearch.lowercased()
            
        }.disabled(locationToSearch.count == 0)
        .padding()
        .background(Color(red: 0, green: 0, blue: 0.8))
        .foregroundColor(.white)
        .clipShape(Capsule())
        
        Button("Delete all CoreData") {
            for entity in ["ReportData", "LocationData"] {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                do {
                    try managedObjectContext.execute(deleteRequest)
                } catch let error as NSError {
                    // TODO: handle the error
                }
            }
        }
        .padding(.top, 100)
        Text("Requires app restart").font(.footnote)
    }
}

struct LocationBrowser_Previews: PreviewProvider {
    static var previews: some View {
        LocationBrowser(programmaticAddTransition: .constant("")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


