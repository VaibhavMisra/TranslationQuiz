//
//  Flow.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

class Flow<R: Router> {
    
    typealias Answer = R.Answer
    
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
            router.routeToQuestion(question: question) { [weak self] answer in
                self?.answers[question] = answer
                self?.routeToQuestion(after: index)
            }
        }
    }
    
    private func routeToQuestion(after index: Int) {
        routeToQuestion(at: questions.index(after: index))
    }
    
}
