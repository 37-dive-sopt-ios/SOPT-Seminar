import UIKit
import Seminar01

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let viewController = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
