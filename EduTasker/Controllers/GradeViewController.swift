import UIKit
import SwiftUI
import Combine

class GradeViewController: UIViewController {
    private let viewModel = GradeViewModel(service: .init(networkProvider: .init()))
    private var cancellables = Set<AnyCancellable>()
    
    lazy var gradeUIHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: GradeView(viewModel: self.viewModel))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(gradeUIHostingController)
        view.addSubview(gradeUIHostingController.view)
        
        viewModel.getStudentGrades()
        viewModel.getStudentCum()
        bindings()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presentSessionExperiendAlert()
        viewModel.getStudentGrades()
        viewModel.getStudentCum()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gradeUIHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            gradeUIHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradeUIHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradeUIHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindings() {
        viewModel.presentSubjectDetail
            .sink { subjectInfo in
                let subjectDetailVC = SubjectViewController(subjectInfo: subjectInfo)
                subjectDetailVC.modalPresentationStyle = .overFullScreen
                
                self.present(subjectDetailVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.presentTokenAlertSubject
            .sink {
                self.presentSessionExperiendAlert()
            }
            .store(in: &cancellables)
    }
    
}
