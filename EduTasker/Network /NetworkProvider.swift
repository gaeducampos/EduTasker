import Foundation
import Combine

struct NetworkProvider {
    enum ErrorHandler: Error {
        case failedRequest(statusCode: Int)
        case unexpectedResponseType
        
        var errorMessage: String {
            switch self {
            case .failedRequest(let statusCode):
                return "Request Failed with status code: \(statusCode)"
            case .unexpectedResponseType:
                return "Unexpected Response Type"
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

