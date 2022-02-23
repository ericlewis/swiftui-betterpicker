import SwiftUI

extension _PickerStyle where Self == _DefaultPickerStyle {
  public static var automatic: Self { .init() }
}

public struct _DefaultPickerStyle: _PickerStyle {
  public func makeBody(configuration: Configuration<Self._SelectionValue>) -> some View {
    Picker(selection: configuration.$selection) {
      configuration.options
    } label: {
      configuration.label
    }
  }
}
