//
//  HTTPTask.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

class Provider<EndPoint: EndPointType> {
    func request(_ route: EndPoint) async throws -> (Data, HTTPURLResponse) {
        let request = try buildRequest(from: route)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }

        return (data, httpResponse)
    }

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path))
        request.httpMethod = route.httpMethod.rawValue

        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
            try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
        }

        return request
    }

    private func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
    }
}
