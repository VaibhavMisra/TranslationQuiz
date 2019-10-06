//
//  ResultViewController.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, Storyboarded {
    
    public var result: GameResult<Question, Bool>?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gameResult = self.result {
            scoreLabel.text = "You scored \n \(gameResult.score) out of \(gameResult.answers.count)"
        }
        
    }
}
