//
//  URLComponents.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String:String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
