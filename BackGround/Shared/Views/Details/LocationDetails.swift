//
//  LocationDetailsView.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/15/21.
//

import SwiftUI

struct LocationDetails: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var locationData: LocationData
    @State var accentColor: Color = Color.gray
    
    var fetchRequest: FetchRequest<ReportData>
    
    @State private var selectedReport: ReportType = ReportType.METAR
    @State private var reportRequest: FetchRequest<ReportData>?
    
    @Binding public var programmaticAddTransition: String
    
    enum ReportType: String, CaseIterable {
        case METAR
        case TAF
        case MOS
    }
    
    init(locationData: LocationData, programmaticAddTransition: Binding<String>) {
        self.locationData = locationData
        self._programmaticAddTransition = programmaticAddTransition
        
        fetchRequest = FetchRequest<ReportData>(entity: ReportData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ReportData.dateIssued, ascending: false)], predicate: NSPredicate(format: "ident == %@", locationData.ident!))
    }
    
    var body: some View {
        if fetchRequest.wrappedValue.count != 0 {
            let firstReport = fetchRequest.wrappedValue[0]
            ZStack() {
                MapView(lat: firstReport.lat, lon: firstReport.lon)
                    .frame(height: 120)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7), .clear]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 120)
                            .padding(.top, 0)
                        .allowsHitTesting(false)
                    )
                VStack(alignment: .leading) {
                    Text(String(format: "%d ft MSL", firstReport.elevation))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    Text(firstReport.flightRules!.uppercased())
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.leading)
            }
        }
        VStack() {
            Picker("Report Type", selection: $selectedReport) {
                ForEach(ReportType.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            List(fetchRequest.wrappedValue, id: \.self) { report in
                switch selectedReport {
                    case ReportType.METAR:
                        METAR(report: report)
                    case ReportType.TAF:
                        TAF(report: report)
                    case ReportType.MOS:
                        MOS()
                }
            }
            .listStyle(InsetListStyle())
            .listRowInsets(EdgeInsets())
            .frame(maxWidth: .infinity)
            .padding(.top, -15)
        }
        .padding(.top, -8)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(locationData.ident!)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(leading: backButton, trailing: favoriteButton)
        .navigationBarHidden(false)
        .onAppear(perform: {
            accentColor = locationData.isFavorite ? Color.yellow : Color.gray
            CoreDataHelper.pruneReportCache(viewContext: managedObjectContext, reports: fetchRequest.wrappedValue)
        })
    }
    
    var favoriteButton: some View {
        Button(action: {
            accentColor = locationData.isFavorite ? Color.gray : Color.yellow
            CoreDataHelper.toggleFavorite(viewContext: managedObjectContext, location: locationData)
        }) {
            Image(systemName: "star").resizable().accentColor(accentColor)
                .frame(width: 30, height: 30)
            
        }
    }
    
    var backButton: some View {
        Button(action: {
            self.programmaticAddTransition = ""
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Text("Go Back")
                .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct LocationDetails_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetails(locationData: PersistenceController.getSampleLocation(), programmaticAddTransition: .constant("")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
