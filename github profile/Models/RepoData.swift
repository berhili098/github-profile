//
//  RepoData.swift
//  github profile
//
//  Created by oussama berhili on 22/5/2025.
//

import Foundation
struct RepoData: Decodable {
    let stargazersCount: Int
    let forksCount: Int
    let language: String?
    let uniqueLanguages: Int?
    
  
}
