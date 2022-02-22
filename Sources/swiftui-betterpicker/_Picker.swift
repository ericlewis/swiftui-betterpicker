import SwiftUI

public enum _Tag {
  case tagged(AnyHashable)
  case untagged

  var value: AnyHashable? {
    if case let .tagged(value) = self {
      return value
    }
    return nil
  }
}

public struct _Picker<Label: View, Content: View, Selection: Hashable>: View {
  private typealias Config = _PickerStyleConfiguration
  
  @Binding 
  private var selection: Selection
  
  @Environment(\._pickerStyle)
  private var style
  
  private let content: () -> Content
  private let label: () -> Label
  
  public init(selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder label: @escaping () -> Label) {
    self._selection = selection
    self.content = content
    self.label = label
  }
  
  public var body: some View {
    style.makeBody(
      configuration: _PickerStyleConfiguration(
        selection: .init(
          get: { AnyHashable(selection) },
          set: { selection = $0 as! Selection }
        ),
        options: { .init(content()) },
        content: { option in
          Config.Content(
            _VariadicView.Tree(
              Root(
                selection: selection,
                option: option
              ),
              content: content
            )
          )
        },
        label: { .init(label()) }
      )
    )
  }
  
  private struct Root: _VariadicView.MultiViewRoot {
    typealias Configuration = _PickerStyleConfiguration
    typealias Children = _VariadicView.Children
    typealias ChildView = Children.Element
    
    let selection: Selection
    let option: (Configuration.Option, _Tag) -> Configuration.Option
    
    func body(children: Children) -> some View {
      ForEach(makeTaggedViews(children), id: \.view.id) { tagged in
        option(.init(tagged.view), tagged.tag)
      }
    }
    
    func makeTaggedViews(_ views: Children) -> [(view: ChildView, tag: _Tag)] {
      views.compactMap { view in
        guard let tag: Selection = view._traits.tags().first else {
          return (view, .untagged)
        }
        return (view, .tagged(tag))
      }
    }
  }
}

extension _Picker where Label == Text {
  public init(_ titleKey: LocalizedStringKey, selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content) {
    self.init(selection: selection, content: content) {
      Text(titleKey)
    }
  }
}

extension _Picker where Label == Text {
  @_disfavoredOverload
  public init<S>(_ title: S, selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content) where S: StringProtocol {
    self.init(selection: selection, content: content) {
      Text(title)
    }
  }
}
