import SwiftUI

internal struct _AnyPickerStyle: _PickerStyle {
  private var _makeBody: (Configuration<AnyHashable>) -> AnyView

  init<S: _PickerStyle>(_ style: S) {
    self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
  }

  func makeBody(configuration: Configuration<AnyHashable>) -> some View {
    _makeBody(configuration)
  }
}
