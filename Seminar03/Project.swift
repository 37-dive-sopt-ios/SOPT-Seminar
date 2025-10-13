import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar03",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
