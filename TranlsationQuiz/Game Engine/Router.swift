//
//  Router.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

protocol Router {
    
    typealias Answer = Bool
    
    func routeToQuestion(question: Question, callback: @escaping (Answer) -> Void)
    func routeTo(result: GameResult<Question, Answer>)
}
