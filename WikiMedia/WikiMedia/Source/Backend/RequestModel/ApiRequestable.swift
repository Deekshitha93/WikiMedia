//
//  ApiRequestable.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

protocol ApiRequestable: ApiEndPoint {
    
}

extension ApiRequestable {
    func requestString() -> String? {
        var urlString = ""
        guard let url = baseUrl else { return urlString }
        urlString.append(url)
        
        guard let parameterList = parameters else { return urlString }
        
        for (key, param) in parameterList {
            let paramString = key + "=" + param + "&"
            urlString.append(paramString)
        }
        
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return encodedUrl
    }
}
