import SwiftUI
import Magister

struct Onboard: View {
    @Binding var session: Session
    @State private var tab = 0
    
    var body: some View {
        TabView(selection: $tab) {
            First(session: $session, tab: $tab)
                .tag(0)
            Second(session: $session, tab: $tab)
                .tag(1)
            Third(session: $session, tab: $tab)
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
