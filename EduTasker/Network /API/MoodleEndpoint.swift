import Foundation

enum MoodleEndpoint {
    case signIn
    case subjectResources(wsfunction: String = "mod_resource_get_resources_by_courses")
    case homeworks(wsfunction: String = "core_calendar_get_calendar_upcoming_view")
    
    var subpath: URL {
        switch self {
        case .signIn:
            return URL(string: "login/token.php")!
        case .subjectResources(let wsfunction):
            return URL(string: "webservice/rest/server.php")!.appendPath(value: "\(wsfunction)", name: "wsfunction")
        case .homeworks(let wsfunction):
            return URL(string: "webservice/rest/server.php")!.appendPath(value: "\(wsfunction)", name: "wsfunction")
        }
    }
    
    var url: URL {
        return URL(string: Self.baseURL + subpath.absoluteString)!
    }
    
    private static var baseURL = "https://uvirtual.ufg.edu.sv/"
}
