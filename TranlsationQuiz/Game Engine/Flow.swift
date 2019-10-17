//
//  Flow.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

class Flow<R: Router> {
    
    let questions: [Question]
    let correctAnswers: [Question: Answer]
    let router: R
    
    var answers = [Question: Answer]()
    
    init(questions: [Question], correctAnswers: [Question: Answer], router: R) {
        self.questions = questions
        self.correctAnswers = correctAnswers
        self.router = router
    }
    
    public func start() {
        routeToQuestion(at: questions.startIndex)
    }
    
    private func routeToQuestion(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            router.routeToQuestion(question: question,
                                   callback: callback(for: question, at: index))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func routeToQuestion(after index: Int) {
        routeToQuestion(at: questions.index(after: index))
    }
    
    private func callback(for question: Question,
                          at index: Int) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.answers[question] = answer
            self?.routeToQuestion(after: index)
        }
    }
    
    private func result() -> GameResult<Question, Answer> {
        let totalScore = answers.reduce(0) { (score, tuple) in
            return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
        }
        return GameResult(questions: questions, answers: answers,
                          correctAnswers: correctAnswers, score: totalScore)
    }
    
}
