import SwiftUICore
import SwiftUI
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
                    StatsView(value: user.followers ?? 0, title: "Followers")
                    StatsView(value: user.following ?? 0, title: "Following")
                    StatsView(value: user.publicRepos ?? 0, title: "Repos")
                }
                .padding(.top)
                Text("\(String(user.calculateWorth())) $")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Estimated worth")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    
                
                
                Spacer()
            }
            .padding()
        }
    }
}



#Preview {
    ContentView()
}
