//
//  NetworkError.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//


enum NetworkError: Error {
    case authError
    case badRequest
    case badResponse
    case outdated
    case failed
    case noData
    case unableToDecode
    case missingURL
    case unknown
    case apiError(CommonErrorResponse)
}
