import SwiftUI

internal struct _AnyPickerStyle<SelectionValue: Hashable>: _PickerStyle {
  private var _makeBody: (Configuration<SelectionValue>) -> AnyView

  init<S: _PickerStyle>(_ style: S) where S.SelectionValue == SelectionValue {
    self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
  }

  func makeBody(configuration: Configuration<SelectionValue>) -> some View {
    _makeBody(configuration)
  }
}
