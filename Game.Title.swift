import SwiftUI

extension Game {
    struct Title: View {
        @Binding var session: Session
        @State private var new = false
        @AppStorage(Defaults.Key.onboard_start.rawValue) private var start = true
        
        var body: some View {
            if start {
                Onboard(session: $session)
            } else if new {
                VStack {
                    Spacer()
                    Text("New\nGame")
                        .multilineTextAlignment(.center)
                        .font(Font.largeTitle.bold())
                        .padding(.bottom)
                    HStack {
                        VStack {
                            Control.Circle(image: "person.fill") {
                                session.match = .init()
                            }
                            Text("Single")
                                .font(.caption2)
                                .offset(y: -10)
                                .zIndex(-1)
                        }
                        .frame(width: 120)
                        VStack {
                            Control.Circle(image: "person.2.fill") {
                                UIApplication.shared.request()
                            }
                            Text("Multiplayer")
                                .font(.caption2)
                                .offset(y: -10)
                                .zIndex(-1)
                        }
                        .frame(width: 120)
                    }
                    .padding(.top)
                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            new = false
                        }
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.secondary)
                            .bold()
                            .frame(minWidth: 100, minHeight: 60)
                    }
                    .contentShape(Rectangle())
                    .padding(.bottom)
                }
            } else {
                VStack {
                    HStack {
                        Text(verbatim: "The\nGlass\nBead\nGame")
                            .font(Font.largeTitle.bold())
                            .padding(80)
                        Spacer()
                    }
                    Spacer()
                    Controls(session: $session, new: $new)
                }
            }
        }
    }
}
