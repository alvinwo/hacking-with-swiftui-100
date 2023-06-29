//
//  ContentView.swift
//  iExpense
//
//  Created by Alvin Wo on 2023/6/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    private let amountFormatter = AmountFormatter()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name).font(.headline.bold())
                            Text(item.type).font(.body)
                        }
                        Spacer()
                        Text(amountFormatter.string(for: item) ?? "error")
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    // func formatAmount(format: FormatStyle) -> FormatStyle.FormatOutput {
//        let formatter  = NumberFormatter()
//        formatter.numberStyle = .currency
//        if value > 10 && value < 100 {
//            formatter.numberStyle = .currencyISOCode
//        } else if value >= 100 {
//            formatter.numberStyle = .currencyAccounting
//        }
//        formatter.maximumFractionDigits = 2

//    }

    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
