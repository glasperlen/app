import SwiftUI

extension Menu {
    struct Item: View {
        let text: LocalizedStringKey
        let image: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.init(.secondarySystemBackground))
                    HStack {
                        Text(text)
                            .font(.footnote)
                        Spacer()
                        Image(systemName: image)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                }
                .frame(height: 50)
            }
            .padding(.horizontal)
        }
    }
}
