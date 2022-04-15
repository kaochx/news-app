//
//  APICaller.swift
//  NewsAPP
//
//  Created by White Kao on 2022/4/15.
//

import Foundation

final class APICaller {
    static let sgared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2589be2d2edc49e5990d1609c7a3eca9")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(String.self, from: data)
                }
                catch {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}

//Models

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}

struct Source: Codable {
    let name: String
}
