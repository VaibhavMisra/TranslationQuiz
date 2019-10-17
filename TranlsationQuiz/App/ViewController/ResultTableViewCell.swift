//
//  ResultTableViewCell.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    func setAnswerlabelTextColor(isCorrect: Bool) {
        answerLabel.textColor = isCorrect ?
            UIColor.systemGreen : UIColor.systemRed
    }
}
