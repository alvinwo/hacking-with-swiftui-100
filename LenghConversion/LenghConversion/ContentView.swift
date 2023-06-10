//
//  ContentView.swift
//  LenghConversion
//
//  Created by Alvin Wo on 2023/6/10.
//

import SwiftUI

struct ContentView: View {
    private let units: [UnitLength] = [.meters, .miles, .kilometers, .feet, .yards, .miles, .inches]
    @State private var sourceIndex: Int = 3
    @State private var destIndex: Int = 4
    @State private var sourceValue: Double = 0.0
    private let unitFormatter = MeasurementFormatter()

    private var outputValue: Double {
        let source = Measurement(value: sourceValue, unit: units[sourceIndex])
        let output = source.converted(to: units[destIndex])
        return output.value
    }

    // Define unitPicker as a closure
    private let unitPicker: () -> ForEach<Range<Int>, Int, Text>

    init() {
        unitFormatter.unitStyle = .long
        // Capture units in a local constant
        let units = self.units
        let formatter = unitFormatter
        unitPicker = {
            ForEach(0 ..< units.count, id: \.self) { index in
                Text(formatter.string(from: Measurement(value: 0, unit: units[index]).unit))
            }
        }
    }

    var body: some View {
        return NavigationView {
            Form {
                Section {
                    Picker("Source Unit", selection: $sourceIndex, content: unitPicker)
                    Picker("Target Unit", selection: $destIndex, content: unitPicker)
                }

                Section {
                    TextField("Enter the value", text: Binding(
                        get: { String(self.sourceValue) },
                        set: {
                            self.sourceValue = Double($0) ?? 0.0
                        }
                    )).keyboardType(.decimalPad)
                } header: {
                    Text("Input")
                }

                Section {
                    Text(String(format: "%.2f", outputValue))
                } header: {
                    Text("Output")
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
