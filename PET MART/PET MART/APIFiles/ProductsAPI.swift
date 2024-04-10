//
//  ProductsAPI.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/7/24.
//

import Foundation
import Alamofire

struct ProductAPIConstants {
    static let scheme = "https"
    static let host = "retoolapi.dev"
    static let path = "/CunxRy/products"
}

class ProductAPIService {
    
    static func showProducts() async throws -> [Product]{
        var urlComponents = URLComponents()
        urlComponents.scheme = ProductAPIConstants.scheme
        urlComponents.host = ProductAPIConstants.host
        urlComponents.path = ProductAPIConstants.path
        
        let task = AF.request(urlComponents.url!, method: .get).serializingDecodable([Product].self)
        let response = await task.response
        guard let jsonData = response.data else { return [] }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let results = try decoder.decode([Product].self, from: jsonData)
            return results
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return []
    }
}
