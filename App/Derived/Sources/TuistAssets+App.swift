// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// MARK: - Asset Catalogs

public enum AppAsset: Sendable {
  public static let icAlarm = AppImages(name: "ic_alarm")
  public static let icChat = AppImages(name: "ic_chat")
  public static let icMenu = AppImages(name: "ic_menu")
  public static let icScan = AppImages(name: "ic_scan")
  public static let icScrap = AppImages(name: "ic_scrap")
  public static let icScrapFill = AppImages(name: "ic_scrap_fill")
  public static let icSearch = AppImages(name: "ic_search")
  public static let item1 = AppImages(name: "item1")
  public static let item10 = AppImages(name: "item10")
  public static let item2 = AppImages(name: "item2")
  public static let item3 = AppImages(name: "item3")
  public static let item4 = AppImages(name: "item4")
  public static let item5 = AppImages(name: "item5")
  public static let item6 = AppImages(name: "item6")
  public static let item7 = AppImages(name: "item7")
  public static let item8 = AppImages(name: "item8")
  public static let item9 = AppImages(name: "item9")
  public static let profile1 = AppImages(name: "profile1")
  public static let profile2 = AppImages(name: "profile2")
  public static let profile3 = AppImages(name: "profile3")
  public static let profile4 = AppImages(name: "profile4")
  public static let profile5 = AppImages(name: "profile5")
  public static let profile6 = AppImages(name: "profile6")
  public static let rectangle2 = AppImages(name: "Rectangle 2")
  public static let rectangle3 = AppImages(name: "Rectangle 3")
  public static let rectangle4 = AppImages(name: "Rectangle 4")
  public static let rectangle5 = AppImages(name: "Rectangle 5")
  public static let rectangle6 = AppImages(name: "Rectangle 6")
}

// MARK: - Implementation Details

public struct AppImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: AppImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: AppImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: AppImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftformat:enable all
// swiftlint:enable all
