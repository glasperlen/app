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
    
    func refresh(_ completion: @escaping (Match?) -> Void) {
        loadMatchData {
            guard $1 == nil else {
                completion(nil)
                return
            }
            completion($0.flatMap {
                try? JSONDecoder().decode(Match.self, from: $0)
            })
        }
    }
    
    func next(_ match: Match, completion: (() -> Void)?) {
        (try? JSONEncoder().encode(match)).map {
            endTurn(withNextParticipants: players, turnTimeout: 10000, match: $0) { error in
                print(error)
                completion?()
            }
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
