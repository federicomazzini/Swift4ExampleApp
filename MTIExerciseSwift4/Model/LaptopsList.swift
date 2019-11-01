//
//  LaptopsList.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let title: String
    let laptopDescription: String
    let imgUrlString: String?

    enum CodingKeys: String, CodingKey {
        case title
        case laptopDescription = "description"
        case imgUrlString      = "image"
    }

}

struct LaptopList: Decodable {
    var list: [Item]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var items = [Item]()

        while !container.isAtEnd {
            let item = try container.decode(Item.self)
            items.append(item)
        }
        
        self.list = items
    }
    
}
