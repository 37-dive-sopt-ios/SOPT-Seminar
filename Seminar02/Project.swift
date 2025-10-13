import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar02",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
