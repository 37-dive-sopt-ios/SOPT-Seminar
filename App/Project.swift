import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "App",
    dependencies: [
        .project(target: "Core", path: "../Core"),
        .project(target: "Seminar01", path: "../Seminar01"),
        .project(target: "Seminar02", path: "../Seminar02")
    ]
)
