//
//  ContentView.swift
//  WeSplit
//
//  Created by Alvin Wo on 2023/6/7.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    private let tipPercentages = [10, 15, 20, 25, 30]
    private let defaultCurrency = "USD"

    var currencyCode: String {
        Locale.current.currency?.identifier ?? defaultCurrency
    }

    var peopleCount: Double {
        Double(numberOfPeople + 2)
    }

    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }

    var totalPerPerson: Double {
        return totalAmount / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode)).keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 10) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }.pickerStyle(.menu)
                    NavigationLink(destination: TipSelectionView(tipPercentage: $tipPercentage)) {
                        Text("Select Tip Percentage")
                    }
                    Text("Current tip: \(tipPercentage)")
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalAmount, format: .currency(code: currencyCode))
                } header: {
                    Text("Total Amount")
                        .foregroundColor(tipPercentage == 0 ? Color.red : Color.black)
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))

                } header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct TipSelectionView: View {
    @Binding var tipPercentage: Int

    var body: some View {
        Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(0 ..< 101) {
                Text($0, format: .percent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
