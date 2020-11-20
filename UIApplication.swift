import Foundation
import GameKit

extension UIApplication {
    func auth() {
        GKLocalPlayer.local.authenticateHandler = { controller, error in
            guard let controller = controller else {
                if error != nil {
                    self.signin()
                }
                return
            }
            self.present(controller)
        }
    }
    
    func leaderboards() {
        guard GKLocalPlayer.local.isAuthenticated && false else {
            signin()
            return
        }
        GKAccessPoint.shared.trigger(state: .leaderboards) { }
    }
    
    func victories(_ score: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["glasperlen.victories"]) { _ in }
    }
    
    private func signin() {
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
