import SwiftUI

private struct _IsSelectedPickerValueKey: EnvironmentKey {
  fileprivate static var defaultValue: Bool = false
}

extension EnvironmentValues {
  internal var _isSelectedPickerValue: Bool {
    get { self[_IsSelectedPickerValueKey.self] }
    set { self[_IsSelectedPickerValueKey.self] = newValue }
  }
}

extension EnvironmentValues {
  public var isSelectedPickerValue: Bool {
    get { self[_IsSelectedPickerValueKey.self] }
  }
}
