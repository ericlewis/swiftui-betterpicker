import SwiftUI

public struct _PickerStyleConfiguration<SelectionValue: Hashable> {
  public struct Content: View {
    private let _view: AnyView
    internal init<V: View>(_ view: V) {
      self._view = AnyView(view)
    }
    public var body: some View { _view }
  }

  public struct Option: View {
    private let _view: AnyView
    public init<V: View>(_ view: V) {
      self._view = AnyView(view)
    }
    public var body: some View { _view }
  }

  public struct Label: View {
    private let _view: AnyView
    internal init<V: View>(_ view: V) {
      self._view = AnyView(view)
    }
    public var body: some View { _view }
  }

  @Binding
  public var selection: SelectionValue
  public let options: Content
  public let content: (@escaping (Option, _Tag<SelectionValue>) -> Option) -> Content
  public let label: Label
}
