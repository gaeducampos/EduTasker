import Foundation

struct UFGSessionInfo: Decodable {
    let status: Int
    let msg: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case status, msg, accessToken = "access_token", refreshToken = "refresh_token"
    }
}
