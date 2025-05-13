//
//  ContentView.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    
       @State  var username : String = "berhili098"
    
    
    var body: some View {
        NavigationView {
            VStack {
              TextFieldWidget(
                text: $username
              )
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
                Spacer()
                AppButtonWidget(title: "submit",
                                    
                                    action: {
                    Task{
                        await   viewModel.fetchUserProfile(username: username)
                    }
                } , isLoading: viewModel.isLoading)
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("GitHub Profile")
            .task {
                await viewModel.fetchUserProfile(username: username)
            }
        }
    }
}





#Preview {
    ContentView()
}
