//
//  GithubService.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import Foundation

protocol GithubServiceProtocol {
    func getUser(username: String) async throws -> GithubUser
}

class GithubService: GithubServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://api.github.com"
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getUser(username: String) async throws -> GithubUser {
        let urlString = "\(baseURL)/users/\(username)"
        return try await networkService.fetchData(from: urlString)
    }
}