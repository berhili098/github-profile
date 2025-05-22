//
//  NetworkService.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError(Error)
}

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            // ✅ Print status code and headers
                       if let httpResponse = response as? HTTPURLResponse {
                           print("🛰️ Response Status Code: \(httpResponse.statusCode)")
                           print("📋 Headers: \(httpResponse.allHeaderFields)")
                       }

                       // ✅ Print raw data as string (JSON text)
                       if let jsonString = String(data: data, encoding: .utf8) {
                           print("📦 Raw JSON: \(jsonString)")
                       }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("what happened")
                throw NetworkError.invalidResponse
            }
                
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            } catch {
                print("ok")
                throw NetworkError.invalidData
            }
        } catch let error as NetworkError {
            print("no")
            throw error
        } catch {
            print("bad")
            throw NetworkError.networkError(error)
        }
    }
}
