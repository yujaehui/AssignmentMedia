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
    
    func fetchTV(api: TVAPI, completionHandler: @escaping ([Result])-> Void) {
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchDetail(api: TVAPI, completionHandler: @escaping (SeriesDetailsModel) -> Void) {
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: SeriesDetailsModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchCredit(api: TVAPI, completionHandler: @escaping (AggregateCreditsModel) -> Void) {
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: AggregateCreditsModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
