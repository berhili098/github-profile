//
//  GithubUser.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import Foundation

struct GithubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let bio: String?
    let name: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case bio
        case name
        case followers
        case following
        case publicRepos = "public_repos"
    }
}