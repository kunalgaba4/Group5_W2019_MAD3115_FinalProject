//
//  Product.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-16.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import Foundation


import Foundation

struct Product: Codable {
    let id: Int
    let imgURL: String
    let name: String
    var price: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imgURL = "imgUrl"
        case name, price
        case description = "Description"
}
}
