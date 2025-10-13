import ProjectDescription

// 공통 Configuration 정의
public let sharedConfigurations: [Configuration] = [
    .debug(name: .configuration("Seminar01")),
    .debug(name: .configuration("Seminar02")),
    .debug(name: .configuration("Seminar03")),
    .debug(name: .configuration("Debug")),
    .release(name: .configuration("Release"))
]

extension Project {
    public static func app(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
            settings: .settings(configurations: sharedConfigurations),
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .app,
                    bundleId: "com.th1ngjin.\(name)",
                    infoPlist: .extendingDefault(with: [
                        "UILaunchStoryboardName": "LaunchScreen",
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
                            "UISceneConfigurations": [
                                "UIWindowSceneSessionRoleApplication": [
                                    [
                                        "UISceneConfigurationName": "Default Configuration",
                                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                    ]
                                ]
                            ]
                        ]
                    ]),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }

    public static func framework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
            settings: .settings(configurations: sharedConfigurations),
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "com.th1ngjin.\(name)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
