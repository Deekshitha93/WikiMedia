//
//  SearchResultPage.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResultPage: BaseModel {
    var title: String?
    var thumbnail: ThumbnailDetail?
    var terms: TermsDetail?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        title <- map[SearchResponseConstant.title]
        thumbnail <- map[SearchResponseConstant.thumbnail]
        terms <- map[SearchResponseConstant.terms]
    }
}
