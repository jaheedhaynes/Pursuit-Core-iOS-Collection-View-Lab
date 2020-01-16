//
//  CountryDetailAPI.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Jaheed Haynes on 1/14/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPIClient {
    static func getCountries(searchQuery: String, completion: @escaping (Result<[Country], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let endpointURLString = "https://restcountries.eu/rest/v2/name/\(searchQuery)"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

