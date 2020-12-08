import SwiftUI
import Magister

struct Tutorial: View {
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            TabView {
                Group {
                    A()
                    B()
                    C()
                    D()
                    E()
                    F()
                    G()
                    H()
                }
                .padding(35)
                .padding(.bottom, 40)
                Group {
                    I()
                    J()
                    K()
                    L()
                    M()
                    N()
                    O()
                    P()
                }
                .padding(35)
                .padding(.bottom, 40)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .foregroundColor(.primary)
                    .font(Font.title2.bold())
                    .frame(minWidth: 100, minHeight: 40)
            }
            .padding(.bottom)
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}

private struct A: View {
    var body: some View {
        VStack {
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding(.vertical)
            HStack {
                Text("Colour")
                    .bold()
                Spacer()
                Text("blue")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            .padding(.top)
            HStack {
                Text("Points")
                    .bold()
                Spacer()
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            .padding(.top)
            HStack {
                Text("Top")
                Spacer()
                Text(verbatim: "1")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Bottom")
                Spacer()
                Text(verbatim: "0")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Left")
                Spacer()
                Text(verbatim: "2")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Right")
                Spacer()
                Text(verbatim: "4")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            Spacer()
            Text("A bead")
                .font(Font.title.bold())
                .padding(.bottom)
            Text("The main element of the game.\nEach one is unique and with different properties.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct B: View {
    var body: some View {
        VStack {
            Text(verbatim: "5")
                .font(Font.largeTitle.bold())
                .padding(.bottom)
            Text("""
You will receive 5 beads at the beginning, this will be your inventory.

When playing you will get new beads when you win, but beads will be taken out of your inventory when you loose.

In your inventory you can select which beads you want to use when playing, it is important to have exactly 5 beads selected to be able to play.

You can also purchase new beads.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct C: View {
    var body: some View {
        VStack {
            Text("Modes")
                .font(Font.largeTitle.bold())
                .padding(.bottom)
            HStack {
                VStack {
                    Image(systemName: "person.fill")
                        .font(.title)
                        .padding()
                    Text("Single")
                        .bold()
                    Text("Play against Artificial Intelligence")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(width: 130, height: 200)
                VStack {
                    Image(systemName: "person.2.fill")
                        .font(.title)
                        .padding()
                    Text("Multiplayer")
                        .bold()
                    Text("Play someone else with Game Center")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(width: 130, height: 200)
            }
        }
    }
}

private struct D: View {
    var body: some View {
        VStack {
            Text("""
Who plays first is decided at random at the beginning of the game.

Notice the different colours between you and your opponent.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Text("Opponent")
                .font(Font.title.bold())
                .padding(.top)
            Image(systemName: "arrowtriangle.up.fill")
                .font(.title)
                .foregroundColor(.opponent)
                .padding(.vertical)
            Image(systemName: "arrowtriangle.down.fill")
                .font(.title)
                .foregroundColor(.user)
                .padding(.vertical)
            Text("You")
                .font(Font.title.bold())
        }
    }
}

private struct E: View {
    var body: some View {
        VStack {
            Board { _ in
                Place(state: .empty)
            }
            Spacer()
            Text("Board")
                .padding(.vertical)
                .font(Font.title.bold())
            Text("This is where the game takes place.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct F: View {
    var body: some View {
        VStack {
            Text(verbatim: "9")
                .font(Font.largeTitle.bold())
                .padding(.vertical)
            Text("""
The board has 9 cells in it.

The objective of the game is to own as many cells as possible.

The game ends when all the cells are owned, the player with the most cells wins.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct G: View {
    var body: some View {
        VStack {
            Board { _ in
                Place(state: .empty)
            }
            Spacer()
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding(.vertical)
            Text("Turns")
                .padding(.vertical)
                .font(Font.title.bold())
            Text("During your turn drag and drop 1 of your beads into an empty cell.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct H: View {
    var body: some View {
        VStack {
            Board {
                Place(state: $0.x == 1 && $0.y == 1 ? .taken(.init(color: .blue, top: 1, bottom: 0, left: 2, right: 4), .user) : .empty)
            }
            Spacer()
            Text("Own")
                .padding(.vertical)
                .font(Font.title.bold())
            Text("When you place a bead into an empty cell you own it and your turn ends.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct I: View {
    var body: some View {
        Text("""
All beads already on the board are said to be in Defensive mode.

When you place a bead into the board this is a considered an Attack.

When placing a bead on an empty cell, your attack is matched against the defense of all the adjacent beads.

Only beads that are directly adjacent to the cell are considered for an attack, also, only beads that are in a cell that shares a side with your cell are considered. Cells sharing a corner or in diagonal are not considered.

All defenses that get overpowered by your attack become yours.
""")
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
    }
}

private struct J: View {
    var body: some View {
        VStack {
            Board {
                Place(state: $0.x == 0 && $0.y == 0 ? .taken(.init(color: .green, top: 0, bottom: 1, left: 1, right: 1), .opponent) : .empty)
            }
            Spacer()
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding(.vertical)
            Text("The green bead already on the board is in defensive mode.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct K: View {
    var body: some View {
        VStack {
            Board {
                Place(state: $0.x == 0 && $0.y == 0 ? .taken(.init(color: .green, top: 0, bottom: 1, left: 1, right: 1), .user) :
                        $0.x == 1 && $0.y == 0 ? .taken(.init(color: .blue, top: 1, bottom: 0, left: 2, right: 4), .user) : .empty)
            }
            Spacer()
            Text("""
The defense (Right = 1) can't stand against your attack (Left = 2).

The defending cell becomes yours.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct L: View {
    var body: some View {
        VStack {
            Board {
                Place(state: $0.x == 0 && $0.y == 0 ? .taken(.init(color: .green, top: 0, bottom: 1, left: 1, right: 1), .opponent) :
                        $0.x == 0 && $0.y == 1 ? .taken(.init(color: .blue, top: 1, bottom: 0, left: 2, right: 4), .user) : .empty)
            }
            Spacer()
            Text("""
In this case the defense (Bottom = 1) holds against your attack (Top = 1).
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct M: View {
    var body: some View {
        VStack {
            Board {
                Place(state: $0.x == 0 && $0.y == 0 ? .taken(.init(color: .green, top: 0, bottom: 1, left: 1, right: 1), .opponent) :
                        $0.x == 1 && $0.y == 1 ? .taken(.init(color: .blue, top: 1, bottom: 0, left: 2, right: 4), .user) : .empty)
            }
            Spacer()
            Text("""
In this case the cells are not sharing a side and there is no attack.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct N: View {
    var body: some View {
        Text("""
Only the side of the beads that touch between them are considered for an attack: Top against Bottom, Left against Right.

Attacks smaller or equal than the defense are ignored.

You can't attack your own cells.
""")
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
    }
}

private struct O: View {
    var body: some View {
        VStack {
            Text(verbatim: "Time Out")
                .font(Font.largeTitle.bold())
                .padding(.bottom)
            Text("""
When playing in single player mode you have no restriction of time; play as relaxed as you want and take your time.

However, in multiplayer matches you have a limit of maximum 1 minute to take your turn; if you get a time out you will automatically loose the game and your opponent is entitled to 1 of your beads.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct P: View {
    var body: some View {
        VStack {
            Text(verbatim: "End Game")
                .font(Font.largeTitle.bold())
                .padding(.bottom)
            Text("""
The winner can choose 1 bead from the looser and add it to their inventory.

Only beads that are selected, that is, only beads that can be used in a game can be taken as a prize.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}
