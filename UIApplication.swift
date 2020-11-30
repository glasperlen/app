import Foundation
import GameKit
import Combine
import Magister

extension UIApplication: GKTurnBasedMatchmakerViewControllerDelegate, GKLocalPlayerListener {
    static let match = PassthroughSubject<Match, Never>()
    private static var game: GKTurnBasedMatch?

    public func player(_ player: GKPlayer, receivedTurnEventFor: GKTurnBasedMatch, didBecomeActive: Bool) {
        Self.game = receivedTurnEventFor
        
        if Defaults.game == nil {
            receivedTurnEventFor.refresh {
                var match = $0 ?? .init()
                match.join(.user(Defaults.id, GKLocalPlayer.local.displayName, Defaults.beads.filter(\.selected).map(\.item)))
                self.next(match)
                Defaults.game = receivedTurnEventFor.matchID
                Self.match.send(match)
            }
            windows.first?.rootViewController?.dismiss(animated: true)
        } else {
            refresh()
        }
    }
    
    public func player(_: GKPlayer, wantsToQuitMatch: GKTurnBasedMatch) {
        Self.game = wantsToQuitMatch
        quit()
    }
    
    public func turnBasedMatchmakerViewController(_ controller: GKTurnBasedMatchmakerViewController, didFailWithError: Error) {
        controller.dismiss(animated: true)
    }
    
    public func turnBasedMatchmakerViewControllerWasCancelled(_ controller: GKTurnBasedMatchmakerViewController) {
        controller.dismiss(animated: true)
    }
    
    func auth() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { controller, error in
            guard let controller = controller else {
                if error == nil {
                    GKLocalPlayer.local.register(self)
                } else {
                    self.sign()
                }
                return
            }
            self.present(controller)
        }
    }
    
    func leaderboards() {
        guard GKLocalPlayer.local.isAuthenticated else {
            sign()
            return
        }
        GKAccessPoint.shared.trigger(state: .leaderboards) { }
    }
    
    func victory() {
        Defaults.victories += 1
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(Defaults.victories, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["glasperlen.victories"]) { _ in }
    }
    
    func request() {
        guard GKLocalPlayer.local.isAuthenticated else {
            sign()
            return
        }
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let controller = GKTurnBasedMatchmakerViewController(matchRequest: request)
        controller.turnBasedMatchmakerDelegate = self
        present(controller)
    }
    
    func load() {
        guard GKLocalPlayer.local.isAuthenticated, let game = Defaults.game else { return }
        GKTurnBasedMatch.load(withID: game) { game, id in
            Self.game = game
            self.refresh()
        }
    }
    
    func refresh() {
        Self.game?.refresh {
            guard let match = $0 else { return }
            Self.match.send(match)
            
            if GKLocalPlayer.local == Self.game?.currentParticipant?.player {
                if case let .play(turn) = match.state {
                    if match[turn].id != Defaults.id {
                        Self.game?.next(match, completion: nil)
                    }
                }
            }
        }
    }
    
    func next(_ match: Match) {
        Self.game?.next(match, completion: nil)
    }
    
    func quit() {
        Self.game?.quit {
            Self.game = nil
            Defaults.game = nil
        }
    }
    
    private func sign() {
        let alert = UIAlertController(title: "Game Center account not found", message: "You can sign in on Settings", preferredStyle: .actionSheet)
        alert.addAction(.init(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        alert.addAction(.init(title: NSLocalizedString("Settings", comment: ""), style: .default) { _ in
            self.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        self.present(alert)
    }
    
    private func present(_ controller: UIViewController) {
        guard var root = windows.first?.rootViewController else { return }
        while let presented = root.presentedViewController {
            root = presented
        }
        root.present(controller, animated: true)
    }
}
