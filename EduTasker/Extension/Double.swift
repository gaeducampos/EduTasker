import Foundation

extension Double {
    func formattedStringWithOneDecimalPlaces() -> String {
        return String(format: "%.1f", self)
    }
}
