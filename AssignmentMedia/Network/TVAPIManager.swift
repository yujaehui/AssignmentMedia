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
    
    let header: HTTPHeaders = ["Authorization": APIKey.tmdbAuthorization]
    let baseURL = "https://api.themoviedb.org/3/"
    let imageeBaseURL = "https://image.tmdb.org/t/p/w500"
    let errorImageURL = "https://lh3.googleusercontent.com/proxy/4qYlpVBIvCD9r_JD8iEEoo-FJE3ecW8wdrDaqCxilzZsoCKSyf5_lXOG8stFWGQp7_Wji7q-2kzwXEXjD4Lx_T53iUZ2HWH03tk"
    
    func fetchTV(url: String, completionHandler: @escaping ([Result])-> Void) {
        let url = baseURL + url
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVList(url: String, completionHandler: @escaping (TVModel) -> Void) {
        let url = baseURL + url
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchDetail(completionHandler: @escaping (SeriesDetailsModel) -> Void) {
        let url = baseURL + "tv/67915?language=ko-KR"
        AF.request(url, headers: header).responseDecodable(of: SeriesDetailsModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchActor(completionHandler: @escaping (AggregateCreditsModel) -> Void) {
        let url = baseURL + "tv/67915/season/1/aggregate_credits?language=ko-KR"
        AF.request(url, headers: header).responseDecodable(of: AggregateCreditsModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
