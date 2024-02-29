// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Twigs",
  platforms: [.macOS(.v13)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "Twigs",
      targets: ["Twigs"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "Twigs",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]),
    .testTarget(
      name: "TwigsTests",
      dependencies: ["Twigs"]),
  ]
)
