import Foundation

enum UFGEndpoint {
    case singIn
    case semester
    case userInfo
    case grades
    case cum
    
    var subpath: String {
        switch self {
        case .singIn:
            return "auth/portal-estudiante/login"
        case .semester:
            return "api/ciclo"
        case .userInfo:
            return "auth/portal-estudiante/user/me"
        case .grades:
            return "https://ra.ufg.edu.sv/api/estudiantes/notas"
        case .cum:
            return "api/estudiante/indicadores"
        }
    }
    
    var url: URL {
        return URL(string: "\(Self.baseURL)\(subpath)")!
    }
    
    var gradesURL: URL {
        return URL(string: "\(subpath)")!
    }
    
    private static var baseURL = "https://estudiantes.ufg.edu.sv/"
    
}
