//
//  InputView.swift
//  Edutainment
//
//  Created by Alvin Wo on 2023/6/25.
//

import SwiftUI

struct InputView: View {
    @Binding var lowerbound: Int
    @Binding var upperBound: Int
    @Binding var questionNum: Int

    @State private var showAlert = false

    var body: some View {
        let start = 2
        let stop = 10
        Form {
            Section("Multiplication Bounds") {
                Stepper(value: $lowerbound, in: start ... stop) {
                    Text("\(lowerbound)")
                } onEditingChanged: { _ in
                    validateBounds()
                }
                Stepper(value: $upperBound, in: start ... stop) {
                    Text("\(upperBound)")
                } onEditingChanged: { _ in
                    validateBounds()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Bounds"),
                    message: Text("The lower bound cannot be greater than the upper bound."),
                    dismissButton: .default(Text("OK")) {
                        upperBound = lowerbound
                    }
                )
            }

            Section("Questions") {
                TextField("number", value: $questionNum, format: .number)
                    .keyboardType(.decimalPad)
            }
        }
    }

    private func validateBounds() {
        showAlert = lowerbound > upperBound
    }
}
