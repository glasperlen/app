import SwiftUI

extension Game {
    struct Title: View {
        @Binding var session: Session
        @AppStorage(Defaults.Key.onboard_start.rawValue) private var start = true
        
        var body: some View {
            if start {
                Onboard(session: $session)
            } else {
                VStack {
                    VStack {
                        HStack {
                            Text(verbatim: "The\nGlass\nBead\nGame")
                                .font(Font.largeTitle.bold())
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(40)
                    Spacer()
                    Controls(session: $session)
                }
            }
        }
    }
}
