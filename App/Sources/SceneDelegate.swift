import UIKit

#if SEMINAR01
import Seminar01
#elseif SEMINAR02 || SEMINAR02_CLOSURE
import Seminar02
#elseif SEMINAR03 || SEMINAR03_MVC || SEMINAR03_CHATLIST || SEMINAR03_CVC
import Seminar03
#elseif SEMINAR04
import Seminar04
#elseif SEMINAR05
import Seminar05
#elseif SEMINAR06
import Seminar06
#elseif SEMINAR07
import Seminar07
#elseif SEMINAR08
import Seminar08
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let rootViewController: UIViewController

        #if SEMINAR01
        rootViewController = LoginViewController()
        #elseif SEMINAR02
        rootViewController = LoginViewController_Delegate()
        #elseif SEMINAR02_CLOSURE
        rootViewController = LoginViewController_Closure()
        #elseif SEMINAR03
        rootViewController = LoginViewController_MVC()
        #elseif SEMINAR03_MVC
        rootViewController = LoginViewController_CustomView()
        #elseif SEMINAR03_CHATLIST
        rootViewController = ChatViewController()
        #elseif SEMINAR03_CVC
        rootViewController = FeedViewController()
        #elseif SEMINAR04
        rootViewController = Seminar04ViewController()
        #elseif SEMINAR05
        rootViewController = Seminar05ViewController()
        #elseif SEMINAR06
        rootViewController = Seminar06ViewController()
        #elseif SEMINAR07
        rootViewController = Seminar07ViewController()
        #elseif SEMINAR08
        rootViewController = Seminar08ViewController()
        #else
        rootViewController = DefaultViewController()
        #endif

        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
}
