import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    lazy var profileHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: ProfileView())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(profileHostingController)
        view.addSubview(profileHostingController.view)
        
        setupConstraints()
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            profileHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    


}
