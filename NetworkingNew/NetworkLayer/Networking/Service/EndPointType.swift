//
//  EndPointType.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

protocol EndPointType {
    var baseURL:    URL          { get }
    var path:       String       { get }
    var httpMethod: HTTPMethod   { get }
    var task:       HTTPTask     { get }
    var headers:    HTTPHeaders? { get }
}
