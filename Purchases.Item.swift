import Foundation

extension Purchases {
    enum Item: String, CaseIterable, Codable {
        case
        blog = "ari.app.blog"
        
        var image: String {
            switch self {
            case .blog: return "square.stack.3d.up.fill"
            }
        }
        
        var title: String {
            NSLocalizedString(rawValue + ".title", comment: "")
        }
        
        var subtitle: String {
            NSLocalizedString(rawValue + ".subtitle", comment: "")
        }
    }
}
