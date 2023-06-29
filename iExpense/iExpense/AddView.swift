//
//  AddView.swift
//  iExpense
//
//  Created by Alvin Wo on 2023/6/28.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var locale = Locale.current

    private let currencyLocales = [
        Locale(identifier: "en_CA"),
        Locale(identifier: "ja_JP"),
        Locale(identifier: "en_US"),
        Locale(identifier: "en_UK"),
        Locale(identifier: "zh_CN"),
    ]

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Types", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                Section {
                    Picker("Currency", selection: $locale) {
                        ForEach(currencyLocales, id: \.self) {
                            Text($0.currency?.identifier ?? "")
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    print("begin append")
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount, locale: locale))
                    print("append")
                    dismiss()
                }
            }
        }
    }
}
