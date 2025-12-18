import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar06",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
