import Foundation

extension Purchases {
    enum Item: String, CaseIterable, Codable {
        case
        low = "glasperlen.low",
        medium = "glasperlen.medium",
        high = "glasperlen.high"
        
        var image: String {
            switch self {
            case .low: return "low"
            case .medium: return "medium"
            case .high: return "high"
            }
        }
        
        var title: String {
            switch self {
            case .low: return NSLocalizedString("Low pack of 5 beads", comment: "")
            case .medium: return NSLocalizedString("Medium pack of 5 beads", comment: "")
            case .high: return NSLocalizedString("High pack of 5 beads", comment: "")
            }
        }
        
        var subtitle: String {
            switch self {
            case .low: return NSLocalizedString("5 new and unique beads with a low chance of having many points", comment: "")
            case .medium: return NSLocalizedString("5 new and unique beads with a medium chance of having manuy points", comment: "")
            case .high: return NSLocalizedString("5 new and unique beads with a high chance of having many points", comment: "")
            }
        }
        
        var tier: Int {
            switch self {
            case .low: return 0
            case .medium: return 30
            case .high: return 60
            }
        }
    }
}
