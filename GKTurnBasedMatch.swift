import GameKit
import Magister

extension GKTurnBasedMatch {
    var active: Bool {
        currentParticipant?.player == GKLocalPlayer.local
    }
    
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
        guard active else { return }
        (try? JSONEncoder().encode(match)).map {
            endTurn(withNextParticipants: players, turnTimeout: 5, match: $0) { error in
                completion?()
            }
        }
    }
    
    func end(_ completion: @escaping () -> Void) {
        guard active else { return }
        participants.forEach {
            $0.matchOutcome = $0.player == GKLocalPlayer.local ? .lost : .won
        }
        endMatchInTurn(withMatch: .init()) { [weak self] _ in
            self?.remove { _ in
                completion()
            }
        }
    }
    
    func quit(_ completion: @escaping () -> Void) {
        if active {
            participantQuitInTurn(with: .quit, nextParticipants: players, turnTimeout: 0, match: matchData ?? .init()) { [weak self] _ in
                self?.remove { _ in
                    completion()
                }
            }
        } else {
            participantQuitOutOfTurn(with: .quit) { [weak self] _ in
                self?.remove { _ in
                    completion()
                }
            }
        }
    }
}
