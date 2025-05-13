import SwiftUI

struct AppButtonWidget: View {
    var title: String
    var action: () -> Void
    var isLoading: Bool = false
    var backgroundColor: Color = Color.blue
    var foregroundColor: Color = Color.white

    var body: some View {
        Button(action: {
            if !isLoading { action() }
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(12)
            .shadow(color: backgroundColor.opacity(0.3), radius: 4, x: 0, y: 2)
            .animation(.easeInOut(duration: 0.2), value: isLoading)
        }
        .disabled(isLoading)
    }
}
