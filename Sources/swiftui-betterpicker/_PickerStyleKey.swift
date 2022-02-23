import SwiftUI

extension View {
  public func pickerStyle<S: _PickerStyle>(_ style: S) -> some View where S.SelectionValue == AnyHashable {
    environment(\._pickerStyle, _AnyPickerStyle<AnyHashable>(style))
  }
}

private struct _PickerStyleKey: EnvironmentKey {
  fileprivate static var defaultValue: _AnyPickerStyle<AnyHashable> = _AnyPickerStyle(.automatic)
}

extension EnvironmentValues {
  internal var _pickerStyle: _AnyPickerStyle<AnyHashable> {
    get { self[_PickerStyleKey.self] }
    set { self[_PickerStyleKey.self] = newValue }
  }
}
