//
//  NetworkService.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

actor NetworkService {
    
    func handleNetworkResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299: return
        case 300...399: throw NetworkError.unknown // Redirect handled separately
        case 400...500: throw NetworkError.authError
        case 501...599: throw NetworkError.badRequest
        case 600:       throw NetworkError.outdated
        default:        throw NetworkError.failed
        }
    }

    func processData<T: Decodable>(type: T.Type, data: Data?, response: HTTPURLResponse?) async throws -> T {
        guard let response = response else {
            throw NetworkError.unknown
        }

        guard let responseData = data else {
            throw NetworkError.noData
        }

        do {
            if (200...299).contains(response.statusCode) {
                return try JSONDecoder().decode(type, from: responseData)
            } else {
                let errorResponse = try JSONDecoder().decode(CommonErrorResponse.self, from: responseData)
                throw NetworkError.apiError(errorResponse)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unableToDecode
        }
    }

    func processDataWithCustomErrorResponse<S: Decodable, E: Decodable>(
        successType: S.Type,
        errorType: E.Type,
        data: Data?,
        response: HTTPURLResponse?
    ) async throws -> Result<S, E> {
        guard let response = response else {
            throw NetworkError.unknown
        }

        do {
            try handleNetworkResponse(response)
            return .success(try await processData(type: successType, data: data, response: response))
        } catch {
            guard let responseData = data else {
                throw NetworkError.noData
            }

            do {
                let errorResponse = try JSONDecoder().decode(errorType, from: responseData)
                return .failure(errorResponse)
            } catch {
                throw NetworkError.unableToDecode
            }
        }
    }
}

// Пример использования:
// let result = try await networkService.processData(type: MyResponseType.self, data: responseData, response: httpResponse)
// 
// let result = try await networkService.processDataWithCustomErrorResponse(
//     successType: SuccessType.self,
//     errorType: ErrorType.self,
//     data: responseData,
//     response: httpResponse
// )

