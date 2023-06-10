//
//  ContentView.swift
//  LenghConversion
//
//  Created by Alvin Wo on 2023/6/10.
//

import SwiftUI

struct ContentView: View {
    
    private let units = ["meters", "kilometers", "feet", "yards", "miles"]
    @State private var sourceUnit= "meters"
    @State private var destUnit = "kilometers"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Source Unit", sources: units, selection: $sourceUnit) {
                        
                    }
                }
            }.navigationTitle("Length Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
