//
//  ContentView.swift
//  Shared
//
//  Created by Matt Goodrich on 5/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var showingLocationBrowser = false
    @State private var newLocationField = ""
    
    @State private var programmaticAddTransition = ""
    
    var body: some View {
        ZStack{
            NavigationView() {
                LocationsList(programmaticAddTransition: $programmaticAddTransition)
                .navigationTitle("BackGround")
                .toolbar {
                    Button(action: { showingLocationBrowser.toggle() }) {
                        Text("Search")
                    }
                }
                .sheet(isPresented: $showingLocationBrowser) {
                    LocationBrowser(programmaticAddTransition: $programmaticAddTransition)
                }
            }
        }
        .animation(.easeInOut)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
