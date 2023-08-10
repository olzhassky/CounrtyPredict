//
//  Struct.swift
//  CounrtyPredict
//
//  Created by Olzhas Zhakan on 10.08.2023.
//

import Foundation

struct Welcome: Codable {
    let count: Int
    let name: String
    let country: [Country]
}

struct Country: Codable {
    let countryID: String
    let probability: Double

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case probability
    }
}
