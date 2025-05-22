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
    private let contUrl = "https://github-contributions-api.jogruber.de/v4"
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getUser(username: String) async throws -> GithubUser {
        let urlString = "\(baseURL)/users/\(username)"
        var user : GithubUser =  try await networkService.fetchData(from: urlString)
        let contributions = try await getUserContributions(username: username)
        let reposData = try await getUserReposData(username: username)
        user.contributions = contributions ?? 0
        user.forks = reposData?.forksCount ?? 0
        user.stars = reposData?.stargazersCount ?? 0
        user.uniqueLanguages = reposData?.uniqueLanguages
        return user
    }
    
    func getUserContributions(username:String) async throws -> Int? {
        let urlString = "\(contUrl)/\(username)"
        let contributionMap: Contribution =  try await networkService.fetchData(from: urlString)
        return contributionMap.total.values.reduce(0, +)
        
    }
    func getUserReposData(username:String) async throws -> RepoData? {
        let urlString = "\(baseURL)/users/\(username)/repos?per_page=1000"
        let repos: [RepoData] = try await networkService.fetchData(from: urlString)

            var stars = 0
            var forks = 0
            var languages = Set<String>()

            for repo in repos {
                stars += repo.stargazersCount
                forks += repo.forksCount
                if let lang = repo.language {
                    languages.insert(lang)
                }
            }
        return RepoData(
            stargazersCount: stars, forksCount: forks, language: "", uniqueLanguages: languages.count
        )
        
        
    }
}
