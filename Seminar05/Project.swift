import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar05",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
