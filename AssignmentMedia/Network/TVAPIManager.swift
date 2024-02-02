//
//  TVAPIManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import Foundation
import Alamofire

class TVAPIManager {
    static let shared = TVAPIManager()
    init() {}
    
    let imageeBaseURL = "https://image.tmdb.org/t/p/w500"
    
    func request<T: Decodable>(type: T.Type, api: TVAPI, completionHandler: @escaping (T)-> Void) {
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
