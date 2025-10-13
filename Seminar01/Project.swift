import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar01",
    dependencies: [
        .project(target: "Core", path: "../Core")
    ]
)
