//
//  TermsDetail.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

class TermsDetail: BaseModel {
    var termDescription: [String]?
    var alias: [String]?
    var label: [String]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        termDescription <- map[TermDetailConstant.description]
        alias <- map[TermDetailConstant.alias]
        label <- map[TermDetailConstant.label]
    }
}

extension TermsDetail {
    var descriptionString: String? {
        guard let descriptionList = termDescription, descriptionList.isEmpty == false else { return nil }
        return descriptionList[0]
    }
}
