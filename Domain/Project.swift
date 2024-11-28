import ProjectDescription


let organizationName = "mangon"

let project = Project(
  name: "Domain",
  targets: [
    .target(
      name: "Domain",
      destinations: .iOS,
      product: .framework,
      bundleId: "com.\(organizationName).Domain",
      sources: ["Sources/**"],
      dependencies: [
        // Third party

        // Module
        .project(target: "Common", path: .relativeToRoot("Common/"), status: .required, condition: .none),
      ],
      settings: .settings(configurations: [
        .debug(name: "Debug"),
        .release(name: "Release"),
      ])
    ),
  ]
)

