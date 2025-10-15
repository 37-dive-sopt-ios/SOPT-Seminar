import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    settings: .settings(configurations: sharedConfigurations),
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
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Core", path: "../Core"),
                .project(target: "Seminar01", path: "../Seminar01"),
                .project(target: "Seminar02", path: "../Seminar02"),
                .project(target: "Seminar03", path: "../Seminar03")
            ],
            settings: .settings(
                base: [:],
                configurations: [
                    .debug(name: .configuration("Seminar01"), settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "SEMINAR01"]),
                    .debug(name: .configuration("Seminar02"), settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "SEMINAR02"]),
                    .debug(name: .configuration("Seminar02Closure"), settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "SEMINAR02_CLOSURE"]),
                    .debug(name: .configuration("Seminar03"), settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "SEMINAR03"]),
                    .debug(name: .configuration("Debug"), settings: [:]),
                    .release(name: .configuration("Release"), settings: [:])
                ]
            )
        )
    ],
    schemes: [
        createSeminarScheme(number: 1),
        createSeminarScheme(number: 2),
        createSeminarScheme(number: 3),
        createSeminarClosureScheme(number: 2)
    ]
)

// 세미나 스킴 생성 함수
private func createSeminarScheme(number: Int) -> Scheme {
    let paddedNumber = number < 10 ? "0\(number)" : "\(number)"
    let seminarName = "Seminar\(paddedNumber)"
    return .scheme(
        name: seminarName,
        shared: true,
        buildAction: .buildAction(targets: ["App"]),
        runAction: .runAction(
            configuration: .configuration(seminarName),
            executable: "App"
        )
    )
}

private func createSeminarClosureScheme(number: Int) -> Scheme {
    let paddedNumber = number < 10 ? "0\(number)" : "\(number)"
    let seminarName = "Seminar\(paddedNumber)Closure"
    return .scheme(
        name: seminarName,
        shared: true,
        buildAction: .buildAction(targets: ["App"]),
        runAction: .runAction(
            configuration: .configuration(seminarName),
            executable: "App"
        )
    )
}
