import Foundation

struct UFGCiclo: Decodable {
    let registerId: Int
    let currentSemesterId: Int
    let currentDate: String
    
    enum CodingKeys: String, CodingKey {
        case registerId = "idCicloRegistro"
        case currentSemesterId = "idCicloUFG"
        case currentDate = "ciclo"
    }
}
