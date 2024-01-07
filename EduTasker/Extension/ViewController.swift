import UIKit

extension UIViewController {
    func presentErrorModal(with errorMessage: String) {
        let errorVC = ErrorModalViewController(text: errorMessage) {
            self.dismiss(animated: true)
        }
        errorVC.modalPresentationStyle = .overFullScreen
        self.present(errorVC, animated: true)
    }
    
    func presentSessionExperiendAlert() {
        if let student = UserDefaults.standard.auth(forKey: NetworkProvider.studentInfo), student.jwt?.expired == true {
            let alertController = UIAlertController(
                title: "Alerta de Sesión",
                message: "Tu sesión ha experirado",
                preferredStyle: .alert
            )
            
            let sendToSignInAction = UIAlertAction(title: "Ok", style: .default) { _ in
                var sceneDelegate: SceneDelegate? {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let delegate = windowScene.delegate as? SceneDelegate else { return nil }
                     return delegate
                }
                
                UserDefaults.standard.removeObject(forKey: NetworkProvider.studentInfo)
                sceneDelegate?.window?.rootViewController = SignInViewController()
            }
            
            alertController.addAction(sendToSignInAction)
            
            self.present(alertController, animated: true)
        }
    }
}
