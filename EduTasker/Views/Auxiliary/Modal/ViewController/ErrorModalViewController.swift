import UIKit
import SwiftUI

class ErrorModalViewController: UIViewController {
    let text: String
    let action: () -> Void

    private lazy var modalErrorHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: ErrorModalView(text: text, action: action))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        hostingController.modalPresentationStyle = .overCurrentContext
        return hostingController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .clear
        
        addChild(modalErrorHostingController)
        view.addSubview(modalErrorHostingController.view)
        
        setupConstraints()
    }
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            modalErrorHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            modalErrorHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modalErrorHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modalErrorHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}
