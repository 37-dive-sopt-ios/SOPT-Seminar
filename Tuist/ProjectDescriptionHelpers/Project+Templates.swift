import ProjectDescription

// MARK: - Project Templates

extension Project {
    /// Framework 프로젝트 생성 헬퍼
    public static func framework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
            settings: .settings(configurations: allConfigurations),
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

    /// 앱 타겟 생성 (여러 환경 지원)
    public static func appTarget(
        name: String,
        bundleId: String,
        configuration: ConfigurationName,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = ["Resources/**"]
    ) -> Target {
        return .target(
            name: name,
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
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
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: .settings(
                base: [:],
                configurations: [.debug(name: configuration)]
            )
        )
    }
}

// MARK: - Scheme Helpers

/// 세미나 스킴 생성 함수
public func createSeminarScheme(number: Int) -> Scheme {
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

/// 세미나 클로저 스킴 생성 함수
public func createSeminarClosureScheme(number: Int) -> Scheme {
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

/// 커스텀 스킴 생성 함수 (환경별 스킴 빠르게 생성)
/// - Parameters:
///   - name: 스킴 이름 (예: "Seminar03CVC", "QA-App")
///   - configurationName: Configuration 이름
///   - targetName: 실행할 타겟 이름
public func createCustomScheme(
    name: String,
    configurationName: String,
    targetName: String = "App"
) -> Scheme {
    return .scheme(
        name: name,
        shared: true,
        buildAction: .buildAction(targets: [.target(targetName)]),
        runAction: .runAction(
            configuration: .configuration(configurationName),
            executable: .target(targetName)
        )
    )
}

/// 환경별 스킴 생성 (DEV / QA / PROD)
/// - Parameters:
///   - environment: 환경 이름 (예: "DEV", "QA", "PROD")
///   - appName: 앱 이름
///   - targetName: 타겟 이름 (기본값: "환경-앱이름")
///   - configuration: Configuration (DEV/QA는 debug, PROD는 release)
public func createEnvironmentScheme(
    environment: String,
    appName: String,
    targetName: String? = nil,
    configuration: ConfigurationName? = nil
) -> Scheme {
    let target = targetName ?? "\(environment)-\(appName)"
    let config = configuration ?? (environment == "PROD" ? .release : .debug)

    return .scheme(
        name: "\(environment)-\(appName)",
        shared: true,
        buildAction: .buildAction(targets: [.target(target)]),
        runAction: .runAction(
            configuration: config,
            executable: .target(target)
        ),
        archiveAction: .archiveAction(configuration: config),
        profileAction: .profileAction(configuration: config),
        analyzeAction: .analyzeAction(configuration: config)
    )
}
