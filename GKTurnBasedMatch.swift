import GameKit
import Magister

extension GKTurnBasedMatch {
    private var players: [GKTurnBasedParticipant] {
        participants
            .filter { $0.player != GKLocalPlayer.local }
            .filter { $0.status != .declined }
            .filter { $0.status != .done }
            .filter { $0.status != .unknown }
            + participants.filter { $0.player == GKLocalPlayer.local }
    }
    
    func refresh(_ completion: @escaping (Match) -> Void) {
        loadMatchData {
            guard $1 == nil else { return }
            $0.flatMap {
                try? JSONDecoder().decode(Match.self, from: $0)
            }.map(completion)
        }
    }
    
    func next(_ match: Match) {
        (try? JSONEncoder().encode(match)).map {
            endTurn(withNextParticipants: players, turnTimeout: 100000, match: $0)
        }
    }
    
    func quit() {
        if currentParticipant?.player == GKLocalPlayer.local {
            participantQuitInTurn(with: .quit, nextParticipants: players, turnTimeout: 0, match: matchData ?? .init()) {
                print($0)
            }
        } else {
            participantQuitOutOfTurn(with: .quit)
        }
    }
}
