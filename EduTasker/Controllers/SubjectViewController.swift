import UIKit
import SwiftUI

class SubjectViewController: UIViewController {
    private let subjectInfo: UFGStudent.UFGStudentGrade
    
    private lazy var subjectDetailHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: SubjectView(subject: subjectInfo, action: {
            self.dismiss(animated: true)
        }))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(subjectDetailHostingController)
        view.addSubview(subjectDetailHostingController.view)
        
        setupConstraints()
    }
    
    init(subjectInfo: UFGStudent.UFGStudentGrade) {
        self.subjectInfo = subjectInfo
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            subjectDetailHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            subjectDetailHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subjectDetailHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subjectDetailHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
