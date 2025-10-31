import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar04",
    dependencies: [
        .project(target: "Core", path: "../Core"),
        .external(name: "SnapKit")
    ]
)
