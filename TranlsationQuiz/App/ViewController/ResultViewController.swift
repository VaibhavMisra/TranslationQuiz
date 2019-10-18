//
//  ResultViewController.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, Storyboarded, UITableViewDataSource {

    public var result: GameResult<Question, Answer>?

    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if let gameResult = self.result {
            scoreLabel.text = "You got \(gameResult.score)/\(gameResult.answers.count) correct"
        }

    }

    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = result?.questions.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell

        if let question = result?.questions[indexPath.row],
            let answer = result?.answers[question],
            let correctAnswer = result?.correctAnswers[question] {
            cell.wordLabel.text = question.word
            cell.translationLabel.text = question.translation
            cell.answerLabel.text = getAnswerText(for: answer,
                                                  correctAnswer: correctAnswer)
            cell.setAnswerlabelTextColor(isCorrect: answer == correctAnswer)
        }
        return cell
    }

    // MARK: - Private Helper
    public func getAnswerText(for answer: Answer, correctAnswer: Answer) -> String {
        var text = ""
        switch answer {
        case .correct: text = "Correct"
        case .incorrect: text = "Incorrect"
        case .noAnswer: text = "Didn't Answer"
        }

        if answer == correctAnswer {
            text += " (You get +1 point)"
        } else {
            text += " (Wrong Answer!)"
        }
        return text
    }
}
