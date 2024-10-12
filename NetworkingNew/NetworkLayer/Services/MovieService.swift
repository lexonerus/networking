//
//  NetworkManager.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

actor MovieService {
    static let environment: NetworkEnvironment = .production
    static let movieAPIKey = "YOUR_API_KEY_HERE"

    private let networkService = NetworkService()
    private let router = Router<MovieApi>()
    
    func getNewMovies(page: Int) async throws -> [Movie] {
        let data = try await router.request(.newMovies(page: page))
        let response = try await networkService.processData(
            type: MovieApiResponse.self,
            data: data.0,
            response: data.1
        )
        return response.movies
    }
}
