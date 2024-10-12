//
//  ParameterEncoding.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding

    public func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        switch self {
        case .urlEncoding:
            guard let urlParameters = urlParameters else { return }
            try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)

        case .jsonEncoding:
            guard let bodyParameters = bodyParameters else { return }
            try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
        }
    }
}
