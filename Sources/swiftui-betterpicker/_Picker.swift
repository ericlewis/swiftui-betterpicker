import SwiftUI

public enum _Tag<Value: Hashable> {
  case tagged(Value)
  case untagged

  var value: Value? {
    if case let .tagged(value) = self {
      return value
    }
    return nil
  }
}

public struct _Picker<Label: View, Content: View, SelectionValue: Hashable>: View {
  private typealias Configuration = _PickerStyleConfiguration<AnyHashable>

  @Binding
  private var selection: SelectionValue

  @Environment(\._pickerStyle)
  private var style

  private let content: Content
  private let label: Label

  public init(
    selection: Binding<SelectionValue>,
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label
  ) {
    self._selection = selection
    self.content = content()
    self.label = label()
  }

  public var body: some View {
    style.makeBody(
      configuration: Configuration(
        selection: .init($selection),
        options: .init(content),
        content: { option in
          Configuration.Content(
            _VariadicView.Tree(
              Root(
                selection: selection,
                option: option
              ),
              content: { content }
            )
          )
        },
        label: Configuration.Label(label)
      )
    )
  }

  private struct Root: _VariadicView.MultiViewRoot {
    typealias Children = _VariadicView.Children
    typealias ChildView = Children.Element
    typealias Option = Configuration.Option

    let selection: SelectionValue
    let option: (Option, _Tag<AnyHashable>) -> Option

    func body(children: Children) -> some View {
      ForEach(makeTaggedViews(children), id: \.view.id) { tagged in
        option(.init(tagged.view), tagged.tag)
      }
    }

    func makeTaggedViews(_ views: Children) -> [(view: ChildView, tag: _Tag<AnyHashable>)] {
      views.compactMap { view in
        guard let tag: SelectionValue = view._traits.tags().first else {
          return (view, .untagged)
        }
        return (view, .tagged(tag))
      }
    }
  }
}

extension _Picker where Label == Text {
  public init(
    _ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.init(selection: selection, content: content) {
      Text(titleKey)
    }
  }
}

extension _Picker where Label == Text {
  @_disfavoredOverload
  public init<S>(
    _ title: S, selection: Binding<SelectionValue>, @ViewBuilder content: @escaping () -> Content
  ) where S: StringProtocol {
    self.init(selection: selection, content: content) {
      Text(title)
    }
  }
}
