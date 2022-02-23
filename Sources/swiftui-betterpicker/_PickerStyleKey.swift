import SwiftUI

extension View {
  public func pickerStyle<S: _PickerStyle>(_ style: S) -> some View {
    environment(\._pickerStyle, _AnyPickerStyle(style) as! _AnyPickerStyle<AnyHashable>)
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
