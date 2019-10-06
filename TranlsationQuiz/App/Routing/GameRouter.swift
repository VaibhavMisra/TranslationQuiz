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
        let vc = QuestionViewController.instantiate()
        vc.question = question
        vc.selection = callback
        navController.pushViewController(vc, animated: true)
    }
    
    func routeTo(result: GameResult<Question, Answer>) {
        
    }
}
