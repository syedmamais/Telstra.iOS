//
//  Country.swift
//  Telstra
//
//  Created by Syed Amais on 12/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

struct Country: Codable {
    let title           : String?
    let facts           : [Fact]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}

struct Fact: Codable {
    let title           : String?
    let imageUrl        : String?
    let description     : String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl       = "imageHref"
        case description
    }
}
