import SwiftUI

public struct _PickerStyleConfiguration {
  public struct Content: View {
    private let _view: AnyView
    internal init<V: View>(_ view: V) {
      self._view = AnyView(view) 
    }
    public var body: some View { _view }
  }
  
  public struct Option: View {
    private let _view: AnyView
    internal init<V: View>(_ view: V) {
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
  public var selection: AnyHashable
  public let options: () -> Content
  public let content: (@escaping (Option, _Tag) -> Option) -> Content
  public let label: () -> Label
}
