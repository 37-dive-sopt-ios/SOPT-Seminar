import UIKit

#if SEMINAR01
import Seminar01
#elseif SEMINAR02
import Seminar02
#elseif SEMINAR03
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

        // 전처리기를 통해 어떤 세미나를 실행할지 결정
        let rootViewController: UIViewController

        #if SEMINAR01
        rootViewController = UINavigationController(rootViewController: LoginViewController())
        #elseif SEMINAR02
        rootViewController = UINavigationController(rootViewController: Seminar02ViewController())
        #elseif SEMINAR03
        rootViewController = UINavigationController(rootViewController: Seminar03ViewController())
        #elseif SEMINAR04
        rootViewController = UINavigationController(rootViewController: Seminar04ViewController())
        #elseif SEMINAR05
        rootViewController = UINavigationController(rootViewController: Seminar05ViewController())
        #elseif SEMINAR06
        rootViewController = UINavigationController(rootViewController: Seminar06ViewController())
        #elseif SEMINAR07
        rootViewController = UINavigationController(rootViewController: Seminar07ViewController())
        #elseif SEMINAR08
        rootViewController = UINavigationController(rootViewController: Seminar08ViewController())
        #else
        rootViewController = UINavigationController(rootViewController: UIViewController())
        #endif

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
