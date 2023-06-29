//
//  AmountFormatter.swift
//  iExpense
//
//  Created by Alvin Wo on 2023/6/29.
//

import Foundation

class AmountFormatter: NumberFormatter {
    override func string(for obj: Any?) -> String? {
        guard let item = obj as? ExpenseItem else {
            return nil
        }

        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = item.locale.currencySymbol
        switch item.amount {
        case 10 ... 99:
            numberFormatter.numberStyle = .currencyISOCode
        case 100...:
            numberFormatter.numberStyle = .currencyAccounting
        default:
            numberFormatter.numberStyle = .none
        }

        return numberFormatter.string(from: NSNumber(value: item.amount)) ?? nil
    }
}
