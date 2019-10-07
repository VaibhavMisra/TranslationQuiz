//
//  FlowTest.swift
//  TranlsationQuizTests
//
//  Created by Vaibhav Misra on 07/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation
import XCTest
@testable import TranlsationQuiz

class FlowTest: XCTestCase {
    
    let router = RouterMock()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(question: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestion() {
        let question1 = Question(word: "W1", translation: "T1")
        
        makeSUT(question: [question1]).start()
        
        XCTAssertEqual(router.routedQuestions, [question1])
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestion_2() {
        let question2 = Question(word: "W2", translation: "T2")
        
        makeSUT(question: [question2]).start()

        XCTAssertEqual(router.routedQuestions, [question2])
    }
    
    func test_start_withTwoQuestions_routeToFirstQuestion() {
        let question1 = Question(word: "W1", translation: "T1")
        let question2 = Question(word: "W2", translation: "T2")
        
        makeSUT(question: [question1, question2]).start()
        
        XCTAssertEqual(router.routedQuestions, [question1])
    }
    
    func test_startTwice_withTwoQuestions_routeToFirstQuestion() {
        let question1 = Question(word: "W1", translation: "T1")
        let question2 = Question(word: "W2", translation: "T2")
        let sut = makeSUT(question: [question1, question2])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, [question1, question1])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestion() {
        let question1 = Question(word: "W1", translation: "T1")
        let question2 = Question(word: "W2", translation: "T2")
        let question3 = Question(word: "W3", translation: "T3")
        let sut = makeSUT(question: [question1, question2, question3])
        sut.start()
        
        router.answerCallback(.noAnswer)
        router.answerCallback(.noAnswer)
        
        XCTAssertEqual(router.routedQuestions, [question1, question2, question3])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let question1 = Question(word: "W1", translation: "T1")
        let sut = makeSUT(question: [question1])
        sut.start()
        
        router.answerCallback(.noAnswer)
        
        XCTAssertEqual(router.routedQuestions, [question1])
    }
    
    func test_start_withOneQuestions_routesToResult() {
        let question1 = Question(word: "W1", translation: "T1")
        makeSUT(question: [question1]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRoutesToResult() {
        let question1 = Question(word: "W1", translation: "T1")
        let question2 = Question(word: "W2", translation: "T2")
        let sut = makeSUT(question: [question1, question2])
        sut.start()
        
        router.answerCallback(.noAnswer)
        
        XCTAssertNil(router.routedResult)
    }
    
    //MARK:- Helpers
    
    func makeSUT(question: [Question], correctAnswers:[Question: Answer] = [Question: Answer]()) -> Flow<RouterMock> {
        return Flow(questions: question, correctAnswers: correctAnswers, router: router)
    }
    
    class RouterMock: Router {
        
        var routedQuestions: [Question] = []
        var routedResult: GameResult<Question, Answer>? = nil
        var answerCallback: (Answer) -> Void = { _ in }
        
        func routeToQuestion(question: Question, callback: @escaping (Answer) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = callback
        }
        
        func routeTo(result: GameResult<Question, Answer>) {
            routedResult = result
        }
    }

}
