import SwiftUI

struct Dismiss: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.down.circle.fill")
                .foregroundColor(.secondary)
                .font(.title)
                .frame(width: 50, height: 50)
        }
        .contentShape(Rectangle())
        .padding(.bottom)
    }
}
