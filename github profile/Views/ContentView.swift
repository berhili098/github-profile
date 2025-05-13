//
//  ContentView.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    @State private var username = "berhili098"
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    
                case .loaded(let user):
                    UserProfileView(user: user)
                    
                case .error(let message):
                    ErrorView(message: message, retryAction: {
                        Task {
                            await viewModel.fetchUserProfile(username: username)
                        }
                    })
                }
            }
            .padding()
            .navigationTitle("GitHub Profile")
            .task {
                await viewModel.fetchUserProfile(username: username)
            }
        }
    }
}

struct UserProfileView: View {
    let user: GithubUser
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: user.avatarUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 120, height: 120)
                
                Text(user.name ?? user.login)
                    .font(.title)
                    .fontWeight(.bold)
                
                if user.login != user.name {
                    Text("@\(user.login)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let bio = user.bio, !bio.isEmpty {
                    Text(bio)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                HStack(spacing: 30) {
                    StatView(value: user.followers ?? 0, title: "Followers")
                    StatView(value: user.following ?? 0, title: "Following")
                    StatView(value: user.publicRepos ?? 0, title: "Repos")
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct StatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.headline)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Error")
                .font(.title)
                .fontWeight(.bold)
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: retryAction) {
                Text("Try Again")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
