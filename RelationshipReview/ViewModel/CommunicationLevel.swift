//
//  CommunicationLevel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

enum CommunicationLevel: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case beginner
    case intermediate
    case expert

    var description: String {
        switch self {
        case .beginner:
            "Beginner"
        case .intermediate:
            "Intermediate"
        case .expert:
            "Expert"
        }
    }
}

enum Gender {
    case male
    case female
    case preferNotToSay
    case nonBinary
}

enum SexualOrientation {
    case gay
    case lesbian
    case straight
    case asexual
    case bisexual
}


