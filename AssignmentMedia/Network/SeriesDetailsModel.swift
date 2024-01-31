//
//  SeriesDetailsModel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import Foundation

struct SeriesDetailsModel: Decodable {
    let backdropPath: String
    let posterPath: String
    let name: String
    let date: String
    let episodeRunTime: [Int]
    let networks: [Network]
    let createdBy: [CreatedBy]
    let overview: String
  
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case name
        case date = "first_air_date"
        case episodeRunTime = "episode_run_time"
        case networks
        case createdBy = "created_by"
        case overview
    }
}

struct CreatedBy: Decodable {
    let name: String
}

struct Network: Decodable {
    let name: String
}


