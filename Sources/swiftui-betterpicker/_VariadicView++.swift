import SwiftUI

internal struct TraitCollection {
  static let traitsKey = "traits"
  static let traitsStorageKey = "storage"
  static let tagKey = "tagged"

  let traits: [Any]
  func tags<Selection: Hashable>() -> [Selection] {
    traits.compactMap {
      withUnsafePointer(to: Mirror(reflecting: $0).descendant(0, Self.tagKey)) {
        $0.pointee as? Selection
      }
    }
  }
}

extension _VariadicView.Children.Element {
  internal var _traits: TraitCollection {
    TraitCollection(
      traits: Mirror(reflecting: self)
        .descendant(TraitCollection.traitsKey, TraitCollection.traitsStorageKey) as? [Any] ?? []
    )
  }
}
