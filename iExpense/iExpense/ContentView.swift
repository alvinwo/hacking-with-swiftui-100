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
                Section(header: Text("Personal")) {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline.bold())
                                Text(item.type)
                                    .font(.body)
                            }
                            Spacer()
                            Text(amountFormatter.string(for: item) ?? "error")
                        }
                    }
                    .onDelete { indices in
                        expenses.personalItems.remove(atOffsets: indices)
                    }
                }

                Section(header: Text("Business")) {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline.bold())
                                Text(item.type)
                                    .font(.body)
                            }
                            Spacer()
                            Text(amountFormatter.string(for: item) ?? "error")
                        }
                    }
                    .onDelete { indices in
                        expenses.businessItems.remove(atOffsets: indices)
                    }
                }
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

    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
