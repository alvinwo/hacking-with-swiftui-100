//
//  Expenses.swift
//  iExpense
//
//  Created by Alvin Wo on 2023/6/28.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
                print("saved, new items: \(items)")
            }
        }
    }

    var personalItems: [ExpenseItem] {
        get {
            items.filter {
                $0.type == "Personal"
            }
        }
        set {
            updateItems(with: newValue, for: "Personal")
        }
    }

    var businessItems: [ExpenseItem] {
        get {
            items.filter {
                $0.type == "Business"
            }
        }
        set {
            updateItems(with: newValue, for: "Business")
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items
                    = decodedItems
                return
            }
        }
        items = []
    }

    private func updateItems(with newItems: [ExpenseItem], for type: String) {
        let existingItems = items.filter { $0.type != type }
        items = existingItems + newItems
    }
}
