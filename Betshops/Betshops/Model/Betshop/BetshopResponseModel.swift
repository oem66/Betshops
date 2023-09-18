//
//  BetshopResponseModel.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation

struct BetshopResponseModel: Codable, Hashable {
    var count: Int
    var betshops: [BetshopModel]
}

struct BetshopModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String?
    var location: BetshopLocation?
//    var id: Int
    var county: String?
//    var city_id: String
    var city: String?
    var address: String?
}

struct BetshopLocation: Codable, Hashable {
    var lng: Double
    var lat: Double
}
