// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// if a specific day needs additional dependencies, add them here
let dayDependencies: [Int: [Target.Dependency]] = [
  6 : [.product(name: "Collections", package: "swift-collections")],
  15 : [.product(name: "SwiftPriorityQueue", package: "SwiftPriorityQueue")]
]

let dayTargets: [Target] = (1...25).map {
  .target(
    name: "Day\($0)",
    dependencies: [
      "Extensions",
      .product(name: "Algorithms", package: "swift-algorithms")
    ] + dayDependencies[$0, default: []])
}

let package = Package(
  name: "AdventofCode2021",
  products: [
    .executable(name: "Main", targets: ["Main"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
    .package(url: "https://github.com/davecom/SwiftPriorityQueue.git", revision: "7b4aa89d9740779f6123929c3e9e7e6b86b83671")
  ],
  targets: [
    .executableTarget(
      name: "Main",
      dependencies: (1...25).map { .byName(name: "Day\($0)") }
    ),
    .target(
      name: "Extensions",
      dependencies: [.product(name: "Algorithms", package: "swift-algorithms")]
    )
  ] + dayTargets
)

