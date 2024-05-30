//
//  DataService.swift
//  PaginationDemoApp
//
//  Created by Watch Your Health on 30/05/24.
//

import Foundation

class DataService {
    
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts(page: Int, pageSize: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        
        let start = page * pageSize
        let end = start + pageSize
        
        print("Start = \(start)",  "End = \(end)")
        guard let url = URL(string: "\(baseURL)?_start=\(start)&_limit=\(pageSize)") else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
