//
//  ServerConstant.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import Alamofire

struct RequestConstant {
    static let baseUrl = "https://en.wikipedia.org/w/api.php?"
}

struct SearchRequestParamenterConstant {
    static let action = "action"
    static let format = "format"
    static let formatversion = "formatversion"
    static let prop = "prop"
    static let titles = "titles"
    static let generator = "generator"
    static let plimit = "plimit"
    static let piprop = "piprop"
    static let wbptterms = "wbptterms"
    static let redirects = "redirects"
    static let gpslimit = "gpslimit"
    static let srsearch = "srsearch"
    static let gpssearch = "gpssearch"
}

struct SearchRequestParameterValueConstant {
    static let query = "query"
    static let formatversion = "2"
    static let prefixSearch = "prefixsearch"
    static let thumbnail = "thumbnail"
    static let description = "description"
    static let suggestion = "suggestion"
    static let json = "json"
}

struct SearchResponseConstant {
    static let query = "query"
    static let pages = "pages"
    static let pageId = "pageid"
    static let title = "title"
    static let thumbnail = "thumbnail"
    static let pageImage = "pageimage"
    static let terms = "terms"
}

struct PageDetailRequestConstant {

}

struct ThumbnailDetailConstant {
    static let source = "source"
    static let width = "width"
    static let height = "height"
}

struct TermDetailConstant {
    static let alias = "alias"
    static let description = "description"
    static let label = "label"
}

enum SearchRequestProp: String {
    case pageImages = "pageimages"
    case pageterms = "pageterms"
}
