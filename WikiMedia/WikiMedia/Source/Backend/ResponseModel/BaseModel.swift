//
//  BaseModel.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    required init?(map: Map) { }
    
    func mapping(map: Map) { }
}
