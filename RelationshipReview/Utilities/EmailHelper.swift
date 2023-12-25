//
//  EmailHelper.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import Foundation

enum EmailHelper {
    static func isValidEmail(_ email: String) -> Bool {
        // Define the regular expression pattern for a valid email
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#

        do {
            // Create a regular expression object
            let regex = try NSRegularExpression(pattern: emailRegex, options: .caseInsensitive)

            // Create an NSRange object
            let range = NSRange(location: 0, length: email.count)

            // Perform the matching
            let isValid = regex.firstMatch(in: email, options: [], range: range) != nil
            return isValid
        } catch {
            // Handle any errors that occur during the regex creation
            print("Error creating regex: \(error)")
            return false
        }
    }
}
