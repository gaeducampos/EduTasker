import Foundation
import JWTDecode

struct Student: Codable {
    let studentId: String
    let moodleToken: String
    let ufgToken: String
    let ufgRefreshToken: String
    
    var jwt: JWT? {
        return try? decode(jwt: ufgToken)
    }
    
}
