//
//  Product.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/7/24.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: String?
    let image1: String?
    let image2: String?
    let image3: String?
    let rating: String?
    let thumbnail: String
    let description: String?
}
