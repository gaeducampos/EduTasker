import UIKit
import SwiftUI
import Combine

class SignInViewController: UIViewController {
    private let viewModel = SignInViewModel(service: .init(networkProvider: .init()))
    private var cancellables = Set<AnyCancellable>()
    
    lazy var signInHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: SignInView(viewModel: self.viewModel), ignoreSafeArea: true)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    override func viewDidLoad() {
        addChild(signInHostingController)
        view.addSubview(signInHostingController.view)
        view.backgroundColor = .white
        
        setupConstraints()
        bindings()
        super.viewDidLoad()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signInHostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signInHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindings() {
        viewModel.errorModalSubject.sink {
            let errorMessage = "Lo sentimos algo salio mal. Intenta de nuevo."
            self.presentErrorModal(with: errorMessage)
        }
        .store(in: &cancellables)
    }
}

