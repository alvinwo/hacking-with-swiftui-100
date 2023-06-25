//
//  ContentView.swift
//  Edutainment
//
//  Created by Alvin Wo on 2023/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var lowerBound = 2
    @State private var upperBound = 8
    @State private var questionNum = 5
    @State private var currentIndex = 0

    @State var questions: [Question] = []
    @State var results: [Int] = []

    var body: some View {
        VStack {
            InputView(lowerbound: $lowerBound, upperBound: $upperBound, questionNum: $questionNum)

            Button("Begin") {
                generateQuestions()
            }

            QuestionView(questions: $questions, results: $results, currentIndex: $currentIndex)
        }
        .padding()
    }

    func generateQuestions() {
        for index in 0 ..< questionNum {
            questions.append(Question(id: index, letOperand: Int.random(in: lowerBound ..< upperBound + 1), rightOperand: Int.random(in: lowerBound ..< upperBound + 1)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
