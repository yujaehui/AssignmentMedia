//
//  ImageSessionManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import Foundation
import Alamofire

final class ImageSessionManager {
    static let shared = ImageSessionManager()
    private init() {}
    
    func request(query: String, completionHandler: @escaping (ImageModel?, ErrorType?) -> Void) {
        let url = URL(string: "https://openapi.naver.com/v1/search/image?query=\(query)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 불러오기 실패")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("응답 불러오기 실패")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("정확한 응답 실패")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ImageModel.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }.resume()
        }
    }
}
