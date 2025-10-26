import UIKit
import Core

// MARK: - ViewController
/// View와 분리된 ViewController
public final class LoginViewController_CustomView: UIViewController {

    // MARK: - Properties
    private let loginView = LoginView()

    // MARK: - Life Cycle
    public override func loadView() {
        self.view = loginView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }

    // MARK: - Setup
    private func setAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func loginButtonDidTap() {
        pushToWelcomeVC()
    }

    // MARK: - Private Methods
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_MVC()
        welcomeViewController.id = loginView.idTextField.text
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}
