//
//  ImageDownloader.swift
//  FilmTestTask
//
//  Created by APPLE on 23.08.2023.
//

import UIKit

protocol ImageDownLoaderProtocol {
    
    func getData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    
    func getImage(for url: String, completion: @escaping (UIImage) -> Void, useCash: Bool)
    
    func warmCache(with url: URL, copletion: @escaping () -> Void)
}

final class ImageDownloader: ImageDownLoaderProtocol {
    
    static let shared = ImageDownloader()
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private let imageDownLoadQueue = DispatchQueue.global(qos: .userInitiated)
    
    func warmCache(with url: URL, copletion: @escaping () -> Void = {}) {

        self.getData(for: url) { result in
            
            switch result {
            case .success(let success):
                
                self.imageDownLoadQueue.async {
                    guard let image = UIImage(data: success) else {
                        return }
                    self.imageCache.setObject(image as UIImage, forKey: url as NSURL)
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getImage(for url: String, completion: @escaping (UIImage) -> Void, useCash: Bool) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        if let data = imageCache.object(forKey: imageUrl as NSURL) {
            completion(data as UIImage)
            return
        }
        self.getData(for: imageUrl) { result in
            switch result {
            case .success(let success):
                self.imageDownLoadQueue.async {
                    guard let image = UIImage(data: success) else { return }
                    self.imageCache.setObject(image as UIImage, forKey: imageUrl as NSURL)
                    completion(image)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
