import Foundation

struct UFGStudentInfo: Decodable {
    let user: User
    let sessionInfo: UFGSessionInfo?

    struct User: Decodable {
        let username: String
        let nombre: String
        let carnet: String
    }
}


