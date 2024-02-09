//
//  AggregateCreditsModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import Foundation

struct AggregateCreditsModel: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
}
