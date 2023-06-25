//
//  Question.swift
//  Edutainment
//
//  Created by Alvin Wo on 2023/6/25.
//

import Foundation

struct Question {
    let id: Int
    let letOperand: Int
    let rightOperand: Int
    let answer: Int

    init(id: Int, letOperand: Int, rightOperand: Int) {
        self.id = id
        self.letOperand = letOperand
        self.rightOperand = rightOperand
        answer = letOperand * rightOperand
    }
}
