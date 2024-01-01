//
//  DesignSystem.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/2/23.
//

import Foundation
import SwiftUI

struct DesignSystem {
    static let textFieldPlaceholderString = "Enter your answer here"
}


extension Gradient {
    static func backgroundColor(_ promptType: PromptType) -> Gradient {
        switch promptType {
        case .general:
            return .backgroundBlueColor
        case .intimacy:
            return .backgroundPinkColor
        case .future:
            return .backgroundGreenColor
        case .unkown:
            return .backgroundYellowColor
        }
    }

    static let backgroundGreenColor = Gradient(colors: [.green2Background, .green1Background])
    static let backgroundPinkColor = Gradient(colors: [.pink2Background, .pink1Background])
    static let backgroundBlueColor = Gradient(colors: [.blue2Background, .blue1Background])
    static let backgroundYellowColor = Gradient(colors: [.yellow2Backgrounf, .yellow1Backgrounf])
}
