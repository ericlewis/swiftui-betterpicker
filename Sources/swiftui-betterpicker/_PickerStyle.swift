import SwiftUI

public protocol _PickerStyle {

  associatedtype Body: View

  func makeBody(configuration: Configuration<SelectionValue>) -> Self.Body

  typealias Configuration = _PickerStyleConfiguration
  typealias SelectionValue = AnyHashable
}
