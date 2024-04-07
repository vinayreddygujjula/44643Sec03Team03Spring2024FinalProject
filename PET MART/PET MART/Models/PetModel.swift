//
//  PetModel.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/7/24.
//

import Foundation

struct Animal: Codable {
    let id: Int
    let type: String
    let breeds: Breeds
    let gender: String
    let name: String
    let description: String?
    let photos: [Photos]?
    let contact: Contact
}

struct Breeds: Codable {
    let primary: String?
    let secondary: String?
    let mixed: Bool?
    let unknown: Bool
}

struct Photos: Codable {
    let small: String?
    let medium: String?
    let large: String?
    let full: String?
}

struct Contact: Codable {
    let email: String?
    let phone: String?
    let address: Address
    
    func toString() -> String{
        let string = """
                Contact :
                Email : \(email ?? "Unknown")
                Phone : \(phone ?? "Unknown")
            """
        return string
    }
}

struct Address: Codable {
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let postcode: String
    let country: String
}
