import ProjectDescription

extension Project {
    public static func app(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
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
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "com.th1ngjin.\(name)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
