//
//  HTTPTask.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//


enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
}