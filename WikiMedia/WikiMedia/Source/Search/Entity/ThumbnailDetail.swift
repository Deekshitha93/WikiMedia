//
//  ThumbnailDetail.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

class ThumbnailDetail: BaseModel {
    var source: String?
    var width: Int?
    var height: Int?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        source <- map[ThumbnailDetailConstant.source]
        width <- map[ThumbnailDetailConstant.width]
        height <- map[ThumbnailDetailConstant.height]
    }
}
