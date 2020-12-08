import SwiftUI

struct Menu: View {
    @Binding var session: Session
    @State private var formatter = NumberFormatter()
    @State private var tutorial = false
    @AppStorage(Defaults.Key.settings_sound.rawValue) private var sound = true
    @AppStorage(Defaults.Key.settings_vibrate.rawValue) private var vibrate = true
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.title3)
                        .frame(width: 60, height: 50)
                }
                .contentShape(Rectangle())
                .padding(.top)
            }
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(Font.largeTitle.bold())
                Text(verbatim: UIApplication.name.value)
                    .font(Font.title.bold())
                Spacer()
                VStack {
                    Text(NSNumber(value: Defaults.beads.count), formatter: formatter)
                        .font(Font.title.bold().monospacedDigit())
                    Text(Defaults.beads.count == 1 ? "Bead" : "Beads")
                        .font(.caption2)
                }
                VStack {
                    Text(NSNumber(value: Defaults.victories), formatter: formatter)
                        .font(Font.title.bold().monospacedDigit())
                    Text(Defaults.victories == 1 ? "Victory" : "Victories")
                        .font(.caption2)
                }
            }
            .padding()
            Item(text: "Purchases", image: "cart") {
                session.purchases.open.send()
            }
            .padding(.top)
            Item(text: "Leaderboards", image: "star") {
                visible.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    UIApplication.shared.leaderboards()
                }
            }
            Item(text: "How to play?", image: "info.circle") {
                tutorial = true
            }
            .sheet(isPresented: $tutorial) {
                Tutorial()
            }
            Switch(text: "Sounds", value: $sound)
                .padding(.top)
            Switch(text: "Vibrate", value: $vibrate)
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
        .onAppear {
            formatter.numberStyle = .decimal
        }
    }
}
