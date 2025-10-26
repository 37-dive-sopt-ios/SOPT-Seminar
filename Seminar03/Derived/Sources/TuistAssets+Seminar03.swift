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

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Seminar03Asset: Sendable {
  public static let icAlarm = Seminar03Images(name: "ic_alarm")
  public static let icChat = Seminar03Images(name: "ic_chat")
  public static let icMenu = Seminar03Images(name: "ic_menu")
  public static let icScan = Seminar03Images(name: "ic_scan")
  public static let icScrap = Seminar03Images(name: "ic_scrap")
  public static let icScrapFill = Seminar03Images(name: "ic_scrap_fill")
  public static let icSearch = Seminar03Images(name: "ic_search")
  public static let item1 = Seminar03Images(name: "item1")
  public static let item10 = Seminar03Images(name: "item10")
  public static let item2 = Seminar03Images(name: "item2")
  public static let item3 = Seminar03Images(name: "item3")
  public static let item4 = Seminar03Images(name: "item4")
  public static let item5 = Seminar03Images(name: "item5")
  public static let item6 = Seminar03Images(name: "item6")
  public static let item7 = Seminar03Images(name: "item7")
  public static let item8 = Seminar03Images(name: "item8")
  public static let item9 = Seminar03Images(name: "item9")
  public static let profile1 = Seminar03Images(name: "profile1")
  public static let profile2 = Seminar03Images(name: "profile2")
  public static let profile3 = Seminar03Images(name: "profile3")
  public static let profile4 = Seminar03Images(name: "profile4")
  public static let profile5 = Seminar03Images(name: "profile5")
  public static let profile6 = Seminar03Images(name: "profile6")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct Seminar03Images: Sendable {
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
  init(asset: Seminar03Images) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: Seminar03Images, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: Seminar03Images) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
