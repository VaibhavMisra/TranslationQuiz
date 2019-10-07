//
//  Question.swift
//  TranlsationQuiz
//
//  Created by Vaibhav Misra on 06/10/19.
//  Copyright © 2019 Vaibhav Misra. All rights reserved.
//

import Foundation

struct Question: Hashable, Decodable {
    let word: String
    let translation: String
    
    private enum CodingKeys : String, CodingKey {
        case word = "text_eng", translation = "text_spa"
    }
}
