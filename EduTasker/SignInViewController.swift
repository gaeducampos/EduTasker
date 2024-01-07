import UIKit
import SwiftUI

class SignInViewController: UIViewController {
    private let viewModel = SignInViewModel(service: .init(networkProvider: .init()))
    
    lazy var signInHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: SignInView(viewModel: self.viewModel))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    override func viewDidLoad() {
        addChild(signInHostingController)
        view.addSubview(signInHostingController.view)
        
        setupConstraints()
        super.viewDidLoad()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signInHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            signInHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

