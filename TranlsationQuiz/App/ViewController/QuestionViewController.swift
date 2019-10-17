//
//  QuestionViewController.swift
//  TranlationGame
//
//  Created by Vaibhav Misra on 02/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, Storyboarded {
    
    public var question: Question?
    public var selection: ((Answer) -> Void)?
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var translationTopConstraint: NSLayoutConstraint!
    
    var timer: Timer?
    var timeRemaining = 5
    var animator: UIViewPropertyAnimator?
    var getTopChange: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true,
                                     block: { [weak self] _ in
            self?.timerAction()
        })
        
        animator = UIViewPropertyAnimator(duration: 5.0, curve: .linear) {
            self.translationTopConstraint.constant += self.getTopChange
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer?.fire()
        animator?.startAnimation()
    }
    
    // MARK: - IBAction methods
    @IBAction func incorrectBtnTapped(_ sender: UIButton) {
        timer?.invalidate()
        selection?(.incorrect)
    }
    
    @IBAction func correctBtnTapped(_ sender: UIButton) {
        timer?.invalidate()
        selection?(.correct)
    }
    
    // MARK: - Private Helper
    private func configureView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getTopChange = self.timerLabel.frame.minY -
            (self.translationLabel.frame.minY + self.translationLabel.frame.height)
        if let question = self.question {
            wordLabel.text = question.word
            translationLabel.text = question.translation
        }
        self.timerLabel.text = "0:0\(timeRemaining)"
    }
    
    private func timerAction() {
        if self.timeRemaining < 0 {
            timer?.invalidate()
            selection?(.noAnswer)
        } else {
            timerLabel.text = "0:0\(timeRemaining)"
        }
        timeRemaining -= 1
    }
}
