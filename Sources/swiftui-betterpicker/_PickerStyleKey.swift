import SwiftUI

extension View {
  public func pickerStyle<S: _PickerStyle>(_ style: S) -> some View where S.SelectionValue == AnyHashable {
    // FIXME: opening exestenials plz
    environment(\._pickerStyle, _AnyPickerStyle(style))
  }
}

private struct _PickerStyleKey<SelectionValue: Hashable>: EnvironmentKey {
  fileprivate static var defaultValue: _AnyPickerStyle<AnyHashable> { _AnyPickerStyle(.automatic) }
}

extension EnvironmentValues {
  internal var _pickerStyle: _AnyPickerStyle<AnyHashable> {
    get { self[_PickerStyleKey<AnyHashable>.self] }
    set { self[_PickerStyleKey<AnyHashable>.self] = newValue }
  }
}
