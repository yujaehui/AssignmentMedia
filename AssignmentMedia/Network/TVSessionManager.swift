//
//  TVSessionManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/6/24.
//

import Foundation

enum ErrorType: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TVSessionManager {
    static let shared = TVSessionManager()
    private init() {}
    
    func fetchTV(completionHandler: @escaping (TVModel?, ErrorType?) -> Void) {
        var url = URLRequest(url: TVAPI.airingToday.endpoint)
        url.addValue(APIKey.tmdbAuthorization, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: url) { data, response, error in
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
                let result = try JSONDecoder().decode(TVModel.self, from: data)
                dump(result)
                completionHandler(result, nil)
            } catch {
                print(error)
                completionHandler(nil, .invalidData)
            }
        }.resume()
    }
}
