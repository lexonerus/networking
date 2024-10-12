//
//  MovieApi.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import Foundation

enum MovieApi {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}

extension MovieApi: EndPointType {
    var environmentBaseURL: String {
        switch MovieService.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .recommended(let id): return "\(id)/recommendations"
        case .popular: return "popular"
        case .newMovies: return "now_playing"
        case .video(let id): return "\(id)/videos"
        }
    }

    var httpMethod: HTTPMethod { .get }

    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: ["page": page, "api_key": MovieService.movieAPIKey])
        default: return .request
        }
    }

    var headers: HTTPHeaders? { nil }
}
