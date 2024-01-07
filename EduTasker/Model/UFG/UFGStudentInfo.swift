import Foundation

struct UFGStudentInfo: Decodable {
    let user: User
    let sessionInfo: UFGSessionInfo?

    struct User: Decodable {
        let carnet: String
    }
}


