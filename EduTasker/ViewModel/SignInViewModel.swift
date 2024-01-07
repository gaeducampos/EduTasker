import Foundation
import Combine

final class SignInViewModel: ObservableObject {
    private let service: SignInService
    private var singInCancellable: AnyCancellable?
    @Published var isloading = false
    
    let errorModalSubject = PassthroughSubject<Void, Never>()
    
    
    init(service: SignInService) {
        self.service = service
    }
    
    func performSingIn(with credentials: SignInPayload) {
        isloading = true
        singInCancellable = service.performSignIn(with: credentials)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print("FAILED WITH ERROR \(failure)")
                    self.isloading = false
                    self.errorModalSubject.send()
                }
            }, receiveValue: { studentInfo in
                print("RESPONSE \(studentInfo)")
                UserDefaults.standard.set(studentInfo, forKey: NetworkProvider.studentInfo)
                self.isloading = false
            })
    }
}
