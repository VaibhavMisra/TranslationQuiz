//
//  DataBuilder.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 07/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

class DataBuilder {
    static let question1 = Question(word: "Hello", translation: "Hola")
    static let question2 = Question(word: "Dog", translation: "Cat")
    
    class func getQuestions() -> [Question] {
        
        let questions = [question1, question2]
        return questions
    }
    
    class func getCorrectAnswers() -> [Question: Answer] {
        let correctAnswers = [question1: Answer.correct, question2:Answer.incorrect]
        return correctAnswers
    }
}
