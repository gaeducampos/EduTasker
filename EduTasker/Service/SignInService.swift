import Foundation
import Combine

struct SignInService {
    let networkProvider: NetworkProvider
    
    private func getUFGSession(with credentials: SignInPayload) -> AnyPublisher<UFGSessionInfo, Error> {
        let encodedCredentials = try? JSONEncoder().encode(credentials)
        
        var request = URLRequest(url: UFGEndpoint.singIn.url)
        request.httpMethod = "POST"
        request.httpBody = encodedCredentials
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        print("## UFG SESSION EP \(request.url?.absoluteString ?? "")")
        
        return networkProvider.perform(for: request)
    }
    
    private func getStudentInfo(with token: String) -> AnyPublisher<UFGStudentInfo, Error> {
        var request = URLRequest(url: UFGEndpoint.userInfo.url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        print("## UFG STUDENT DATA \(request.url?.absoluteString ?? "")")
        return networkProvider.perform(for: request)
    }

    private func performMoodleSingIn(with credentials: SignInPayload) -> AnyPublisher<MoodleSingIn, Error> {
        let endpoint = MoodleEndpoint.signIn.url
            .appendPath(value: credentials.username, name: "username")
            .appendPath(value: credentials.password, name: "password")
            .appendPath(value: "moodle_mobile_app", name: "service")
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        print("## MOODLE DATA \(request.url?.absoluteString ?? "")")
        return networkProvider.perform(for: request)
    }
        
    private func performUFGSignIn(with credentials: SignInPayload) -> AnyPublisher<UFGStudentInfo, Error> {
        getUFGSession(with: credentials)
            .flatMap { sessionInfo -> AnyPublisher<UFGStudentInfo, Error> in
                getStudentInfo(with: sessionInfo.accessToken)
                    .map { studentInfo in
                        return UFGStudentInfo(user: studentInfo.user, sessionInfo: sessionInfo)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func performSignIn(with credentials: SignInPayload) -> AnyPublisher<Student, Error> {
        performUFGSignIn(with: credentials)
            .flatMap { studenInfo in
                performMoodleSingIn(with: credentials)
                    .compactMap { moodleSession -> Student in
                        return Student(
                            studentId: studenInfo.user.carnet,
                            moodleToken: moodleSession.token,
                            ufgToken: studenInfo.sessionInfo?.accessToken ?? "",
                            ufgRefreshToken: studenInfo.sessionInfo?.refreshToken ?? "")
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
