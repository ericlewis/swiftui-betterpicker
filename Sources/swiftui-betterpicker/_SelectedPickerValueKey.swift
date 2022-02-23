import SwiftUI

private struct _SelectedPickerValueKey: EnvironmentKey {
  fileprivate static var defaultValue: Bool = false
}

extension EnvironmentValues {
  internal var _isSelectedPickerValue: Bool {
    get { self[_SelectedPickerValueKey.self] }
    set { self[_SelectedPickerValueKey.self] = newValue }
  }
}

extension EnvironmentValues {
  public var isSelectedPickerValue: Bool {
    get { self[_SelectedPickerValueKey.self] }
  }
}
