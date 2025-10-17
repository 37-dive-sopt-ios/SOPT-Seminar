// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "SnapKit": .framework
        ]
    )
#endif

let package = Package(
    name: "SOPT-Seminar",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1")
    ]
)
