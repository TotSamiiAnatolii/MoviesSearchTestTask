//
//  NetworkManager.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func fetchModels<T: Decodable>(from url: URLRequest, in completion: @escaping ((Result<T, Error>) -> Void))
}

final class NetworkManager: NetworkServiceProtocol {
    
    func fetchModels<T: Decodable>(from url: URLRequest, in completion: @escaping ((Result<T, Error>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            }
            catch {
                completion(.failure(error))
                print("decode error: \(error)")
            }
        }.resume()
    }
}
