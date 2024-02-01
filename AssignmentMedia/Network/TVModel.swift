//
//  TVModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import Foundation

// airing, trending, top, popular, recommend
struct TVModel: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let poster_path: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case poster_path
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
