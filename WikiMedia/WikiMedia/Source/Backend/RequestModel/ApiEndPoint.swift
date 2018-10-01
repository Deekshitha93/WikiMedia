//
//  ApiEndPoint.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

typealias ApiParams = [String: String]
typealias ApiHeaders = [String: String?]

protocol ApiEndPoint {
    var baseUrl: String?            { get }
    var path: String?               { get }
    var queryUrl: String?           { get }
    var methodName: HttpMethodName? { get }
    var headers: ApiHeaders?        { get }
    var parameters: ApiParams?      { get }
}

extension ApiEndPoint {
    internal var baseUrl: String?            { return nil }
    internal var path: String?               { return nil }
    internal var queryUrl: String?           { return nil }
    internal var methodName: HttpMethodName? { return .get }
    internal var headers: ApiHeaders?        { return nil }
    internal var parameters: ApiParams?      { return nil }
}
