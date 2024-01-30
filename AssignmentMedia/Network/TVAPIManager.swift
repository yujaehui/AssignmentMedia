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
    
    func fetchTV(url: String, completionHandler: @escaping (([Result])-> Void)) {
        let url = url
        let header: HTTPHeaders = ["Authorization": APIKey.tmdbAuthorization]
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
