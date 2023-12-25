//
//  NetworkService.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation
import UIKit

struct NetworkService {
    
    func fetchData(_ url: URL) async -> Data? {
        guard let (data,_) = try? await URLSession.shared.data(from: url) else {
            return fetchDataFromLocalFile(url)
        }
        return data
    }
    
    func fetchDataFromLocalFile(_ url: URL) -> Data? {
        let url = URL(fileURLWithPath: url.absoluteString)
        return try? Data(contentsOf: url)
    }
}
