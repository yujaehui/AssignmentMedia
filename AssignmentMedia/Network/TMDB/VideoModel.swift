//
//  VideoModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/13/24.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let id: Int
    let results: [VideoResult]
}

// MARK: - Result
struct VideoResult: Codable {
    let key: String

    enum CodingKeys: String, CodingKey {
        case key
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
    }
}
