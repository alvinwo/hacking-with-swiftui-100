//
//  QuestionView.swift
//  Edutainment
//
//  Created by Alvin Wo on 2023/6/25.
//

import SwiftUI

struct QuestionView: View {
    @Binding var questions: [Question]
    @Binding var results: [Int]
    @Binding var currentIndex: Int

    @State private var answer = 0
    @State private var showAlert = false

    var body: some View {
        VStack {
            Form {
                if currentIndex < questions.count {
                    Section("Please Calculate the Result:") {
                        Text("\(questions[currentIndex].letOperand) x \(questions[currentIndex].rightOperand) = ?")
                        TextField("Answer: ", value: $answer, format: .number)
                            .keyboardType(.decimalPad)
                        Button("Submit") {
                            results.append(answer == questions[currentIndex].answer ? 1 : 0)
                            currentIndex += 1
                            if currentIndex == questions.count {
                                showAlert = true
                                currentIndex -= 1
                            }
                            print(currentIndex)
                        }
                    }
                }
            }.alert(isPresented: $showAlert) {
                let finalScore = results.reduce(0) { partialResult, value in
                    partialResult + value
                }

                return Alert(
                    title: Text("Finish!"),
                    message: Text("Your Final Score Is \(finalScore)"),
                    dismissButton: .default(Text("OK")) {
                        questions.removeAll()
                        results.removeAll()
                        currentIndex = 0
                    }
                )
            }
        }
    }
}
