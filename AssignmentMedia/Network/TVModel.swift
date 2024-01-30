//
//  TVModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import Foundation

struct TVModel: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let poster_path: String?
}
