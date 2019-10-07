//
//  DataBuilder.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 07/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

class DataBuilder {
    
    var fileName: String
    var masterSet = [Question]()
    var questions = [Question]()
    var correctAnswers = [Question: Answer]()
    
    init(fileName: String) {
        self.fileName = fileName
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let jsonData = try Data(contentsOf: url)
            masterSet = try JSONDecoder().decode([Question].self, from: jsonData)
        }
        } catch {
            assertionFailure("Couldn't load master set")
            print(error.localizedDescription)
        }
        initData()
    }
    
    private func initData() {
        for _ in 1...5 {
            if let question = masterSet.randomElement(),
                let isCorrect = [true, false, true, false, true].randomElement() {
                switch isCorrect {
                case true:
                    questions.append(question)
                    correctAnswers[question] = .correct
                case false:
                    var incorrectTranslation = "hola"
                    if let randomQuestion = masterSet.randomElement() {
                        incorrectTranslation = randomQuestion.translation
                    }
                    let incorrectQuestion = Question(word: question.word, translation: incorrectTranslation)
                    questions.append(incorrectQuestion)
                    correctAnswers[incorrectQuestion] = .incorrect
                }
            }
        }
    }
}
