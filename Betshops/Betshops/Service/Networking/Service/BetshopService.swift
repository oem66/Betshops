//
//  BetshopService.swift
//  Betshops
//
//  Created by Omer Rahmanovic on 18. 9. 2023..
//

import Foundation

protocol BetshopServiceProtocol {
    func getBetshops(model: BetshopRequestModel) async -> Result<BetshopResponseModel, RequestError>
}

final class BetshopService: HTTPClient, BetshopServiceProtocol {
    func getBetshops(model: BetshopRequestModel) async -> Result<BetshopResponseModel, RequestError> {
        return await sendRequest(endpoint: BetshopEndpoint.getBetshops(model: model), responseModel: BetshopResponseModel.self)
    }
}
