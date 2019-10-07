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
    
    var timer: Timer?
    var timeRemaining = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true,
                                     block: { [weak self] timer in
            self?.timerAction()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer?.fire()
    }
    
    //MARK: - IBAction methods
    @IBAction func incorrectBtnTapped(_ sender: UIButton) {
        timer?.invalidate()
        selection?(.incorrect)
    }
    
    @IBAction func correctBtnTapped(_ sender: UIButton) {
        timer?.invalidate()
        selection?(.correct)
    }
    
    //MARK: - Private Helper
    private func configureView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let question = self.question {
            wordLabel.text = question.word
            translationLabel.text = question.translation
        }
        self.timerLabel.text = "0:0\(timeRemaining)"
    }
    
    private func timerAction() {
        timeRemaining -= 1
        if self.timeRemaining < 0 {
            timer?.invalidate()
            selection?(.noAnswer)
        } else {
            timerLabel.text = "0:0\(timeRemaining)"
        }
    }
}
