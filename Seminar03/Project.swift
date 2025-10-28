import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Seminar03",
    settings: .settings(configurations: allConfigurations),
    targets: [
        .target(
            name: "Seminar03",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.th1ngjin.Seminar03",
            infoPlist: .default,
            sources: [
                "Sources/MVC/**",
                "Sources/TableViewSeminar/**",
                "Sources/CollectionViewSeminar/**"
            ],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Core", path: "../Core"),
                .external(name: "SnapKit")
            ]
        )
    ]
)
