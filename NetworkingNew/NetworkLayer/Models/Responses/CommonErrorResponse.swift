//
//  CommonErrorResponse.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//


import Foundation

// MARK: - CommonErrorResponse
struct CommonErrorResponse: Codable {
    let statusMessage: String
    let success: Bool
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case statusCode = "status_code"
    }
}
