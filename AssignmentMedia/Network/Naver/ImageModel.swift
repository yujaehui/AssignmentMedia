//
//  ImageModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import Foundation

struct ImageModel: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let thumbnail: String
    let sizeheight, sizewidth: String
    
    enum CodingKeys: CodingKey {
        case title
        case link
        case thumbnail
        case sizeheight, sizewidth
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
        self.sizeheight = try container.decodeIfPresent(String.self, forKey: .sizeheight) ?? ""
        self.sizewidth = try container.decodeIfPresent(String.self, forKey: .sizewidth) ?? ""

    }
}
