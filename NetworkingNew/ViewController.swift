//
//  ViewController.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let movieService = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        fetchNewMovies()
    }

    private func fetchNewMovies() {
        Task {
            do {
                let movies = try await movieService.getNewMovies(page: 1)
                // Обработка полученных фильмов
                print("Получено \(movies.count) новых фильмов")
            } catch let error as NetworkError {
                switch error {
                case .apiError(let errorResponse):
                    showAlert(with: "API Error: \(errorResponse.statusMessage)")
                default:
                    showAlert(with: "Network error: \(error.localizedDescription)")
                }
            } catch {
                showAlert(with: "Unexpected error: \(error.localizedDescription)")
            }
        }
    }

    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
