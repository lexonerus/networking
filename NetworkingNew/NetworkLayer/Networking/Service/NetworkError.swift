//
//  NetworkError.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//


public enum NetworkError: Error {
    case badResponse
    case missingURL
    case encodingFailed
}