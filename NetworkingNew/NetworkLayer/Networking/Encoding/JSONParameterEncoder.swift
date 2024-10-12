//
//  JSONParameterEncoder.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        urlRequest.httpBody = jsonData

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
