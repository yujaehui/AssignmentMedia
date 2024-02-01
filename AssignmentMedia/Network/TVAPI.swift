//
//  TVAPI.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import Foundation
import Alamofire

enum TVAPI {
    case airingToday
    case trending
    case top
    case popular
    case detail(id: Int)
    case credit(id: Int)
    case recommend(id : Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .airingToday:
            return URL(string: baseURL + "tv/airing_today")!
        case .trending:
            return URL(string: baseURL + "trending/tv/week")!
        case .top:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .detail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .credit(let id):
            return URL(string: baseURL + "tv/\(id)/season/1/aggregate_credits")!
        case .recommend(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["language": "ko-KR"]
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdbAuthorization]
    }
}
