//
//  GithubUser.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import Foundation

struct GithubUser: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    let bio: String?
    let name: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    var stars: Int?
    var forks: Int?
    var contributions: Int?
    let yearsActive: Int?
    var uniqueLanguages: Int?
    
    
    
    
  
    
    
    func calculateWorth() -> Double {
        let repos = Double(publicRepos ?? 0)
        let fols = Double(followers ?? 0)
        let stars = Double(stars ?? 0)
        let forks = Double(forks ?? 0)
        let contribs = Double(contributions ?? 0)
        let years = Double(yearsActive ?? 0)
        let langs = Double(uniqueLanguages ?? 0)
        
        print("repos: \(repos)")
        print("fols: \(fols)")
        print("stars: \(stars)")
        print("forks: \(forks)")
        print("contribs: \(contribs)")
        print("years: \(years)")
        print("langs: \(langs)")
//        
        let total =
          (repos * 1.5) +
           (fols * 2.0) +
           (stars * 1.8) +
           (forks * 1.2) +
           (contribs * 0.5) +
           (years * 2.0) +
           (langs * 1.0)
        let formatted = String(format: "%.2f", total)

        return Double(formatted) ?? total
    }

}
