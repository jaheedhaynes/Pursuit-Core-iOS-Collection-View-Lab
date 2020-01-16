//
//  FlagImageAPIClient.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Jaheed Haynes on 1/15/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation
import UIKit
import NetworkHelper

struct FlagImageAPIClient {
    
    static func fetchImageURL(for imageURL: URL, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        
        let request = URLRequest(url: imageURL)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let data):
                let image = UIImage(data: data)
                completion(.success(image))
            }
        }
    }
}
