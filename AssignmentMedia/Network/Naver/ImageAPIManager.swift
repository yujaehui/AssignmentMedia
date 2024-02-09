//
//  ImageAPIManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import Foundation
import Alamofire

final class ImageAPIManager {
    static let shared = ImageAPIManager()
    init() {}
    
    // let baseURL = "https://openapi.naver.com/v1/search/image"
    private let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.clientID,
                               "X-Naver-Client-Secret": APIKey.clientSecret]
    
    
    func request(query: String, completionHandler: @escaping (ImageModel)-> Void) {
        AF.request("https://openapi.naver.com/v1/search/image?query=\(query)", headers: headers).responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
