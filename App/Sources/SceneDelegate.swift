import UIKit

#if SEMINAR05
import SwiftUI
#endif

#if SEMINAR01
import Seminar01
#elseif SEMINAR02 || SEMINAR02_CLOSURE
import Seminar02
#elseif SEMINAR03 || SEMINAR03_MVC || SEMINAR03_CHATLIST || SEMINAR03_CVC || SEMINAR03_DIFFABLE || SEMINAR03_BAEMIN
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
        #elseif SEMINAR03_DIFFABLE
        rootViewController = DiffableViewController()
        #elseif SEMINAR03_BAEMIN
        rootViewController = BaeminTabBarController()
        #elseif SEMINAR04
        rootViewController = BasicNetworkViewController()  // 기본 네트워크 학습용
        #elseif SEMINAR05
        // SwiftUI View를 UIHostingController로 래핑
        let swiftUIView = LoginView_SwiftUI()
        rootViewController = UIHostingController(rootView: swiftUIView)
        #elseif SEMINAR06
        rootViewController = Seminar06ViewController()
        #elseif SEMINAR07
        rootViewController = Seminar07ViewController()
        #elseif SEMINAR08
        rootViewController = Seminar08ViewController()
        #else
        rootViewController = DefaultViewController()
        #endif

        #if SEMINAR03_BAEMIN
        window?.rootViewController = rootViewController
        #else
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        #endif
        window?.makeKeyAndVisible()
    }
}
