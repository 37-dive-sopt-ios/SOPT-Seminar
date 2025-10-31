import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    settings: .settings(configurations: allConfigurations),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.th1ngjin.App",
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
                ],
                "NSAppTransportSecurity": [
                    "NSAllowsArbitraryLoads": true
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Seminar01", path: "../Seminar01"),
                .project(target: "Seminar02", path: "../Seminar02"),
                .project(target: "Seminar03", path: "../Seminar03"),
                .project(target: "Seminar04", path: "../Seminar04")
            ],
            settings: .settings(
                base: [:],
                configurations: allConfigurations
            )
        )
    ],
    schemes: [
        createSeminarScheme(number: 1),
        createSeminarScheme(number: 2),
        createSeminarScheme(number: 3),
        createSeminarClosureScheme(number: 2),
        .scheme(
            name: "Seminar03MVC",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(
                configuration: .configuration("Seminar03MVC"),
                executable: "App"
            )
        ),
        .scheme(
            name: "Seminar03ChatList",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(
                configuration: .configuration("Seminar03ChatList"),
                executable: "App"
            )
        ),
        .scheme(
            name: "Seminar03CVC",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(
                configuration: .configuration("Seminar03CVC"),
                executable: "App"
            )
        ),
        .scheme(
            name: "Seminar03Diffable",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(
                configuration: .configuration("Seminar03Diffable"),
                executable: "App"
            )
        ),
        .scheme(
            name: "Seminar04",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(
                configuration: .configuration("Seminar04"),
                executable: "App"
            )
        )
    ]
)
