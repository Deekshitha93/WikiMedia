//
//  SearchApiManager.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

typealias SearchCompletionCallback = (_ success: Bool, _ response: SearchResponse?, _ error: Error?) -> Void

extension ApiManager {
    func getSearchResult(of term: String?, completionCallBack: @escaping SearchCompletionCallback) {
        guard let searchTerm = term else {
            completionCallBack(false, nil, nil)
            return
        }
        
        let request = SearchRequestable.search(term: searchTerm)
        excecute(request: request) { (success, response, error) in
            
            if success {
                let searchResponse = Mapper<SearchResponse>().map(JSONObject: response)
                completionCallBack(success, searchResponse, nil)
            } else {
                completionCallBack(false, nil, error)
            }
        }
    }
}
