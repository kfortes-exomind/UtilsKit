// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "UtilsKit",
	platforms: [.iOS("15.0"), .macOS("14.0")],
	products: [
		.library(
			name: "UtilsKitCore",
			targets: ["UtilsKitCore"]),
		.library(
			name: "UtilsKitHelpers",
			targets: ["UtilsKitHelpers"]),
		.library(
			name: "UtilsKitUI",
			targets: ["UtilsKitUI"]),
	],
	targets: [.target(
				name: "UtilsKitCore",
				dependencies: []),
			  .target(
				name: "UtilsKitHelpers",
				dependencies: ["UtilsKitCore"]),
			  .target(
				name: "UtilsKitUI",
				dependencies: ["UtilsKitHelpers"])
	]
)
