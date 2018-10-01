//
//  SearchResponse.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponse: BaseResponse {
    var query: SearchQuery?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        query <- map[SearchResponseConstant.query]
    }
}

class SearchQuery: BaseModel {
    var pages: [SearchResultPage]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        pages <- map[SearchResponseConstant.pages]
    }
}
