//
//  GameResult.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

public struct GameResult<Question: Hashable, Answer> {
    public let questions: [Question]
    public let answers: [Question: Answer]
    public let correctAnswers: [Question: Answer]
    public let score: Int
}
