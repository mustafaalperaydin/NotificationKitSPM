// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationKitSPM",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "NotificationKitSPM",
            targets: ["NotificationKitSPM"]
        ),
    ],
    dependencies: [
        // ✅ Lottie'nin daha küçük SPM versiyonunu kullanıyoruz
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0")
    ],
    targets: [
        .target(
            name: "NotificationKitSPM",
            dependencies: [
                // ✅ product ve package ismi doğru yazılmış
                .product(name: "Lottie", package: "lottie-spm")
            ]
        )
    ]
)
