//
//  Model.swift
//  DOTS
//
//  Created by Claudio Cantieni on 08.04.22.
//

import Foundation

class Model: Identifiable, Decodable {
    var question: String
    var id: UUID?
}
