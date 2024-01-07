import Foundation

struct Student: Codable {
    let studentId: String
    let moodleToken: String
    let ufgToken: String
    let ufgRefreshToken: String
}
