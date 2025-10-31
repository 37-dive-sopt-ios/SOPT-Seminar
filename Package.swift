// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "SnapKit": .framework,
            "FlexLayout": .framework,
            "PinLayout": .framework,
            "Then": .framework,
            "yoga": .staticLibrary
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: "Seminar01"),
                .debug(name: "Seminar02"),
                .debug(name: "Seminar02Closure"),
                .debug(name: "Seminar02FlexLayout"),
                .debug(name: "Seminar03"),
                .debug(name: "Seminar03MVC"),
                .debug(name: "Seminar03ChatList"),
                .debug(name: "Seminar03CVC"),
                .debug(name: "Seminar03Diffable"),
                .debug(name: "Seminar04"),
                .debug(name: "Debug"),
                .release(name: "Release")
            ]
        )
    )
#endif

let package = Package(
    name: "SOPT-Seminar",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
        .package(url: "https://github.com/layoutBox/FlexLayout", from: "2.0.0"),
        .package(url: "https://github.com/layoutBox/PinLayout", from: "1.10.0"),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0")
    ]
)
