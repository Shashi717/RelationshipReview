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

struct NetworkClient {
  let networkService = NetworkService()

  func fetchPrompts(_ urlString: String) async -> [Prompt]? {
    guard let url = URL(string: urlString),
          let data = await networkService.fetchData(url) else {
      return nil
    }
    return try? JSONDecoder().decode([Prompt].self, from: data)
  }

  func submitPrompts(_ urlString: String, _ answers: AnswersToSubmit) -> Bool {
    guard let url = URL(string: urlString) else {
      return false
    }
    // TODO: Submit to backend
    let data = try? JSONEncoder().encode(answers)
    UserDefaults.standard.setValue(data, forKey: "Submitted")
    return true
  }

  func fetchReview(_ urlString: String) async -> Review? {
    guard let url = URL(string: urlString),
          let data = await networkService.fetchData(url) else {
      return nil
    }
    return try? JSONDecoder().decode(Review.self, from: data)
  }

  func markAsDiscussion(_ urlString: String, _ id: String) async -> Bool {
    guard let url = URL(string: urlString) else {
      return false
    }
    // TODO: Submit to backend
    return true
  }

  func fetchImage(_ urlString: String) async -> UIImage? {
    guard let url = URL(string: urlString),
          let data = await networkService.fetchData(url) else {
      return nil
    }
    return UIImage(data: data)
  }
}
