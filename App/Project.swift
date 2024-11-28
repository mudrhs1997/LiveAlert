import ProjectDescription

let appName = "LiveAlert"
let organizationName = "mangon"

let infoPlist: [String: Plist.Value] = [
  "UILaunchStoryboardName": "LaunchScreen", // Launch screen configuration
  "CFBundleVersion": "1", // Prevent bundle version error
  "UIApplicationSceneManifest": [
    "UIApplicationSupportsMultipleScenes": true,
    "UISceneConfigurations": [
      "UIWindowSceneSessionRoleApplication": [
        [
          "UISceneClassName": "UIWindowScene",
          "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
        ]
      ]
    ]
  ]
]

let project = Project(
  name: appName,
  targets: [
    .target(
      name: appName,
      destinations: .iOS,
      product: .app,
      bundleId: "com.\(organizationName).\(appName)",
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        // Third party
        //        .external(name: "RxSwift", condition: .none),

        // Module
        .project(target: "Presentation", path: .relativeToRoot("Presentation/"), status: .required, condition: .none),
        .project(target: "Data", path: .relativeToRoot("Data/"), status: .required, condition: .none),
        .project(target: "Domain", path: .relativeToRoot("Domain/"), status: .required, condition: .none),
      ],
      settings: .settings(configurations: [
        .debug(name: "Debug"),
        .release(name: "Release"),
      ])
    ),

    .target(
      name: "\(appName)UnitTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.\(organizationName).\(appName)UnitTests",
      infoPlist: .default,
      sources: ["UnitTests/**"],
      dependencies: [
        .target(name: appName, status: .optional, condition: .none),
      ]
    ),

    .target(
      name: "\(appName)UITests",
      destinations: .iOS,
      product: .uiTests,
      bundleId: "com.\(organizationName).\(appName)UITests",
      infoPlist: .default,
      sources: ["UITests/**"],
      dependencies: [
        .target(name: appName, status: .optional, condition: .none),
      ]
    ),

  ]
)
