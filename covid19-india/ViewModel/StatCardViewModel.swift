import Foundation

struct StatCardViewModel: Codable {
    var title: String
    var value: Double
    
    init(title: String, value: Double) {
        self.title = title
        self.value = value
    }
}
