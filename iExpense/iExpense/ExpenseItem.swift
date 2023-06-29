//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alvin Wo on 2023/6/28.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
