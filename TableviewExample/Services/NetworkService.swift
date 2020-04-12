//
//  NetworkService.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-10.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case pokemon
}

class NetworkService {
    private let kBaseUrl = "https://pokeapi.co/api/v2"
    
    func sendRequest(withEndpoint endPoint: String?,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let endPoint = endPoint else {
            return
        }
        
        guard let url = URL(string: "\(kBaseUrl)/\(endPoint)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
    }
}
