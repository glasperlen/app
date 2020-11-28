import Foundation
import GameKit
import Combine
import Magister

extension UIApplication: GKTurnBasedMatchmakerViewControllerDelegate, GKLocalPlayerListener {
    static let newMatch = PassthroughSubject<Match, Never>()
    static let newTurn = PassthroughSubject<GKTurnBasedMatch, Never>()
    
    public func player(_ player: GKPlayer, didModifySavedGame savedGame: GKSavedGame) {
        print("modify saved game")
    }
    
    public func player(_ player: GKPlayer, receivedTurnEventFor: GKTurnBasedMatch, didBecomeActive: Bool) {
        Self.newTurn.send(receivedTurnEventFor)
        
        if Defaults.id == nil {
            receivedTurnEventFor.refresh {
                var match: Match
                if let loaded = $0 {
                    match = loaded
                    match.matched()
                } else {
                    match = .init()
                    match.multiplayer()
                }
                receivedTurnEventFor.next(match) {
                    Defaults.id = receivedTurnEventFor.matchID
                    Self.newMatch.send(match)
                }
            }
            windows.first?.rootViewController?.dismiss(animated: true)
        } else {
            receivedTurnEventFor.refresh {
                guard let match = $0 else { return }
                Self.newMatch.send(match)
                
                if didBecomeActive {
                    if (match.state == .first && player != receivedTurnEventFor.participants.first?.player)
                        || (match.state == .second && player != receivedTurnEventFor.participants.last?.player) {
                        receivedTurnEventFor.next(match, completion: nil)
                    }
                }
            }
        }
    }
    
    public func player(_: GKPlayer, wantsToQuitMatch: GKTurnBasedMatch) {
        Defaults.id = nil
        Defaults.match = nil
        wantsToQuitMatch.quit()
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
                    self.signIn()
                }
                return
            }
            self.present(controller)
        }
    }
    
    func leaderboards() {
        guard GKLocalPlayer.local.isAuthenticated else {
            signIn()
            return
        }
        GKAccessPoint.shared.trigger(state: .leaderboards) { }
    }
    
    func victory() {
        Defaults.victories += 1
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(Defaults.victories, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["glasperlen.victories"]) { _ in }
    }
    
    func requestMatch() {
        guard GKLocalPlayer.local.isAuthenticated else {
            signIn()
            return
        }
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let controller = GKTurnBasedMatchmakerViewController(matchRequest: request)
        controller.turnBasedMatchmakerDelegate = self
        present(controller)
    }
    
    private func signIn() {
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
