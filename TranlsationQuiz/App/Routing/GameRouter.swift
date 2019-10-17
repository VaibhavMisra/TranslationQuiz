//
//  GameRouter.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class GameRouter: Router {

    var navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }

    func routeToQuestion(question: Question, callback: @escaping (Answer) -> Void) {
        let questionVC = QuestionViewController.instantiate()
        questionVC.question = question
        questionVC.selection = callback
        navController.pushViewController(questionVC, animated: true)
    }

    func routeTo(result: GameResult<Question, Answer>) {
        let resultVC = ResultViewController.instantiate()
        resultVC.result = result
        navController.pushViewController(resultVC, animated: true)
    }
}
