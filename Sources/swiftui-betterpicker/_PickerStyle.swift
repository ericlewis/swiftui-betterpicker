import SwiftUI

public protocol _PickerStyle {
  associatedtype Body: View
  func makeBody(configuration: Configuration) -> Self.Body
  typealias Configuration = _PickerStyleConfiguration
}
