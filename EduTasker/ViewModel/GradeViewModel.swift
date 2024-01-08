import Foundation
import Combine

class GradeViewModel: ObservableObject {
    private var service: GradeService
    private var gradesCancellable: AnyCancellable?
    private var cumCancellable: AnyCancellable?
    
    let presentSubjectDetail = PassthroughSubject<UFGStudent.UFGStudentGrade, Never>()
    let presentTokenAlertSubject = PassthroughSubject<Void, Never>()
    
    @Published var studentSemesterInfo: UFGStudent?
    @Published var studentCum: UFGCum?
    @Published var studentInfo: Student?
    @Published var isLoading = false
    
    init(service: GradeService) {
        self.service = service
        self.studentInfo = NetworkProvider.student
    }
    
    
    func getStudentGrades() {
        gradesCancellable = service.getStudentSemesterInfo()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print("FAILURE GETTING GRADES \(failure)")
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] studentSemesterInfo in
                self?.studentSemesterInfo = studentSemesterInfo
            })
    }
    
    func getStudentCum() {
        self.isLoading = true
        cumCancellable = service.getStudentCum()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print("FAILURE GETTING CUM \(failure)")
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] studentCum in
                if let studentCum = studentCum.first(where: { $0.type == .cum }) {
                    self?.studentCum = studentCum
                    self?.isLoading = false
                }
            })
    }
    
    
    
    
}
