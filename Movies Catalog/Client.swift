//
//  Client.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import Foundation
import Alamofire

struct Client {
  typealias failureHandler = (_ error: Error) -> Void
  static func request<T: Codable>(url: URL, method: HTTPMethod, params: [String: Any], responseType: T.Type, success: @escaping (_ t: T) -> Void, failure: @escaping failureHandler) {
    Alamofire.request(url, method: method, parameters: params).responseJSON { response in
      print(response.request?.url!)
      
      switch response.result {
      case .failure(let error):
        failure(error)
      case .success(let value):
        print(value)
        
        guard response.response?.statusCode == 200 else {
          let json = response.value as! [String: Any]
          let statusCode = json["status_code"] as! Int
          let statusMessage = json["status_message"] as! String
          let error = NSError(domain: TMDB.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: statusMessage])
          failure(error)
          return
        }
        
        if let data = response.data {
          do {
            let result = try JSONDecoder().decode(responseType, from: data)
            success(result)
          } catch let dataError {
            failure(dataError)
          }
        }
      }
    }
  }
}
