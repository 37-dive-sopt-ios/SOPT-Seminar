import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar07",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
