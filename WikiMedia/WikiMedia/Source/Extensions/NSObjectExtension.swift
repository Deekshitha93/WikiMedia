//
//  NSObjectExtension.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

extension NSObject {
    class func className() -> String {
        return String(describing: self)
    }
}
