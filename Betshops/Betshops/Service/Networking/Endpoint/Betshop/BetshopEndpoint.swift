//
//  Superology.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation

enum BetshopEndpoint {
    case getBetshops(model: BetshopRequestModel)
}

extension BetshopEndpoint: Endpoint {
    var host: String {
        switch self {
        case .getBetshops:
            return "interview.superology.dev"
        }
    }
    
    var path: String {
        switch self {
        case .getBetshops:
            return "/betshops"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getBetshops:
            return .GET
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getBetshops:
            return nil
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getBetshops(model: let model):
            return [
                "boundingBox": model.boundingBox
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getBetshops:
            return nil
        }
    }
}
