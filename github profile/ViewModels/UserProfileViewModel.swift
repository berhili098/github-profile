//
//  UserProfileViewModel.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import Foundation
import SwiftUI
import Combine


enum UserProfileState {
    case loading
    case loaded(GithubUser)
    case error(String)
    case idle
}

class UserProfileViewModel: ObservableObject {
    @Published private(set) var state: UserProfileState = .idle
    @Published  var username = "berhili098"
    private var cancellables = Set<AnyCancellable>()

    private let githubService: GithubServiceProtocol
    var isLoading: Bool {
        switch state {
        case .loading, .idle:
            return true
        default:
            return false
        }
    }
    
    init(githubService: GithubServiceProtocol = GithubService()) {
        self.githubService = githubService
        
        observeTextField()
        
    
      
        
    }
    
    
    private func observeTextField() {
         $username
             .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
             .removeDuplicates()
             .receive(on: RunLoop.main)
             .sink{[weak self]  _ in
                 guard let self = self else { return }
                                Task { await self.fetchUserProfile() }
             }
             .store(in: &cancellables)
         
      
     }
    
    
    @MainActor
    func fetchUserProfile() async {
        state = .loading
        
        do {
            let user = try await githubService.getUser(username: username)
            state = .loaded(user)
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                state = .error("Invalid URL")
            case .invalidResponse:
                state = .error("Server error. Please try again later.")
            case .invalidData:
                state = .error("Could not process the data. Please try again.")
            case .networkError(let underlyingError):
                state = .error("Network error: \(underlyingError.localizedDescription)")
            }
        } catch {
            state = .error("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
}
