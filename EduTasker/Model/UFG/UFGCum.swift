import Foundation

struct UFGCum: Decodable {
    let type: CustomType
    let title: String
    let value: Double
    
    enum CustomType: String, Decodable {
        case level
        case cum
    }
}
