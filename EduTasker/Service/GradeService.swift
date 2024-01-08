import Foundation
import Combine

struct GradeService {
    var networkProvider: NetworkProvider
    
    private func getSemesterInfo() -> AnyPublisher<UFGCiclo, Error> {
        var request = URLRequest(url: UFGEndpoint.semester.url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkProvider.student?.jwt?.string ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return networkProvider.perform(for: request)
    }
    
    private func getGrades(currentSemesterId: String) -> AnyPublisher<UFGStudent, Error> {
        let url = URL(string: UFGEndpoint.grades.gradesURL.absoluteString + "/\(NetworkProvider.student?.studentId ?? "")")!
            .appendPath(value: currentSemesterId, name: "idCiclo")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkProvider.student?.jwt?.string ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return networkProvider.perform(for: request)
    }
    
    private func requestStudentCum(semesterDate: String) -> AnyPublisher<[UFGCum], Error> {
        let url = URL(string: UFGEndpoint.cum.url.absoluteString + "/\(NetworkProvider.student?.studentId ?? "")" + "/\(semesterDate)")!
        
        print("## URL \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkProvider.student?.jwt?.string ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return networkProvider.perform(for: request)
    }
    
    func getStudentCum() -> AnyPublisher<[UFGCum], Error> {
        getSemesterInfo()
            .flatMap { semesterInfo -> AnyPublisher<[UFGCum], Error> in
                return requestStudentCum(semesterDate: semesterInfo.currentDate)
            }
            .eraseToAnyPublisher()
    }
    
    
    func getStudentSemesterInfo() -> AnyPublisher<UFGStudent, Error> {
        getSemesterInfo()
            .flatMap { semesterInfo -> AnyPublisher<UFGStudent, Error> in
                return getGrades(currentSemesterId: "\(semesterInfo.currentSemesterId)")
            }
            .eraseToAnyPublisher()
    }
    
}
