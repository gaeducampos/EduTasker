import Foundation
import JWTDecode
import Combine

struct NetworkProvider {
    static var studentInfo = "Student"
    
    static var student: Student? {
        guard let student = UserDefaults.standard.auth(forKey: Self.studentInfo) else { return nil }
        return student
    }
    
    enum ErrorHandler: Error {
        case failedRequest(statusCode: Int)
        case unexpectedResponseType
        case failedGettingStudent
        
        var errorMessage: String {
            switch self {
            case .failedRequest(let statusCode):
                return "Request Failed with status code: \(statusCode)"
            case .unexpectedResponseType:
                return "Unexpected Response Type"
            case .failedGettingStudent:
                return "Student not stored in user defaults"
            }
        }
    }
    
    func perform(
        for request: URLRequest
    ) -> AnyPublisher<Data?, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) in
                
                guard let response = response as? HTTPURLResponse else {
                    throw ErrorHandler.unexpectedResponseType
                }
                
                guard (200...299).contains(response.statusCode) else {
                    throw ErrorHandler.failedRequest(statusCode: response.statusCode)
                }
                
                return data
                
            }
            .eraseToAnyPublisher()
    }
    
    func perform<Value: Decodable>(
        for request: URLRequest,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Value, Error> {
        return self.perform(for: request)
            .compactMap { $0 }
            .decode(type: Value.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

