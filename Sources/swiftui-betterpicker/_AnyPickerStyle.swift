import SwiftUI

internal struct _AnyPickerStyle: _PickerStyle {
  private var _makeBody: (Configuration) -> AnyView
  
  init<S: _PickerStyle>(_ style: S) {
    self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
  }
  
  func makeBody(configuration: Configuration) -> some View {
    _makeBody(configuration)
  }
}
