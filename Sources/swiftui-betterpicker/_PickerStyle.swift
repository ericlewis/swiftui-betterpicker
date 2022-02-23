import SwiftUI

public protocol _PickerStyle {

  associatedtype SelectionValue: Hashable
  associatedtype Body: View

  func makeBody(configuration: Configuration<Self.SelectionValue>) -> Self.Body

  typealias Configuration = _PickerStyleConfiguration
  typealias _SelectionValue = AnyHashable
}
