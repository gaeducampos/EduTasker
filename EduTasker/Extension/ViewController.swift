import UIKit

extension UIViewController {
    func presentErrorModal(with errorMessage: String) {
        let errorVC = ErrorModalViewController(text: errorMessage) {
            self.dismiss(animated: true)
        }
        errorVC.modalPresentationStyle = .overFullScreen
        self.present(errorVC, animated: true)
    }
}
