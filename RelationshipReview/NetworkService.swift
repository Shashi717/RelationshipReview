//
//  NetworkService.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

struct NetworkService {

  func fetchData(_ url: URL) async -> Data? {
    guard let (data,_) = try? await URLSession.shared.data(from: url) else {
      return nil
    }
    return data
  }
}

struct NetworkClient {
  func fetchPrompts(_ urlString: String) async -> [Prompt]? {
    guard let url = URL(string: urlString),
          let data = await NetworkService().fetchData(url) else {
      return nil
    }
    return try? JSONDecoder().decode([Prompt].self, from: data)
  }

  // temp method for reading from local file
  func fetchPrompts(_ url: URL) -> [Prompt]? {
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }
    return try? JSONDecoder().decode([Prompt].self, from: data)
  }
}
