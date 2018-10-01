//
//  ApiManager.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import Alamofire

typealias ApiResponse = (_ succes: Bool, _ response: Any?, _ error: Error?) -> Void

enum HttpMethodName {
    case get
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        }
    }
}

class ApiManager {
    
    func excecute(request: ApiRequestable, completion: @escaping ApiResponse) {
        guard let urlString = request.baseUrl, let httpMethod = request.methodName?.httpMethod else {
            completion(false, nil, nil)
            return
        }
        
        Alamofire.request(urlString, method: httpMethod, parameters: request.parameters).responseJSON { response in
            if response.result.isSuccess {
                completion(true, response.result.value, nil)
            } else {
                completion(true, nil, response.error)
            }
        }
    }
}
