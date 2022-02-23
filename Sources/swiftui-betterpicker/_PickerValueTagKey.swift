import SwiftUI

private struct _PickerValueTagKey: EnvironmentKey {
  fileprivate static var defaultValue: _Tag = .untagged
}

extension EnvironmentValues {
  internal var _pickerValueTag: _Tag {
    get { self[_PickerValueTagKey.self] }
    set { self[_PickerValueTagKey.self] = newValue }
  }
}

extension EnvironmentValues {
  public var pickerValueTag: _Tag {
    get { self[_PickerValueTagKey.self] }
  }
}

