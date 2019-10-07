//
//  QuestionViewController.swift
//  TranlationGame
//
//  Created by Vaibhav Misra on 02/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class QuestionViewController : UIViewController, Storyboarded {
    
    public var question: Question?
    public var selection: ((Answer) -> Void)?
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var translationTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let question = self.question {
            wordLabel.text = question.word
            translationLabel.text = question.translation
        }
    }
    
    @IBAction func incorrectBtnTapped(_ sender: UIButton) {
        selection?(.incorrect)
    }
    
    @IBAction func correctBtnTapped(_ sender: UIButton) {
        selection?(.correct)
    }
}
