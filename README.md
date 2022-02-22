# BetterPicker

A better SwiftUI Picker. Use `_Picker` instead of `Picker`. Create styles with `_PickerStyle`.

### The is a WIP
This library is currently a work-in-progress with regards to ironing out the API & documentation.
Once both are in a good state a release will be cut. Until then you can point to `main` and deal with 
an unstable interface! Bug reports, testing, ideas, pull requests, and more are welcome!

## Examples
You can find examples in the [`BetterPickerExamples`](BetterPickerExamples.swiftpm) App Playground. 

```swift
import SwiftUI
import BetterPicker

struct ContentView: View {
  enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var title: String { rawValue.localizedCapitalized }
  }

  @State
  private var selection = DayOfWeek.tuesday

  @State
  private var isEnabled = true

  var body: some View {
    NavigationView {
      VStack(spacing: 15) {
        Spacer()
        _Picker("Testing", selection: $selection) {
          ForEach(DayOfWeek.allCases, id: \.self) {
            Text($0.title).tag($0)
          }
          Text("Not a real option.")
        }
        .pickerStyle(.arrow)
        .disabled(!isEnabled)
        .font(.largeTitle)
        Spacer()
        Button("Toggle Disabled") {
          isEnabled.toggle()
        }
        .buttonStyle(.bordered)
        .padding()
      }
      .navigationTitle(selection.title)
    }
    .navigationViewStyle(.stack)
  }
}

extension _PickerStyle where Self == ArrowStyle {
  static var arrow: ArrowStyle { .init() }
}

struct ArrowStyle: _PickerStyle {
  func makeBody(configuration: Configuration) -> some View {
    Style(configuration: configuration)
  }

  struct Style: View {
    let configuration: Configuration

    @Environment(\.isEnabled)
    private var isEnabled

    var body: some View {
      HStack(alignment: .selection) {
        Image(systemName: "arrow.right")
          .symbolVariant(.circle.fill)
          .symbolRenderingMode(.hierarchical)
          .selectionGuide()
          .foregroundColor(.accentColor)
        VStack(alignment: .leading) {
          configuration.content { view, tag in
              .init(makeOption(view, tag))
          }
        }
      }
      .foregroundColor(isEnabled ? .primary : .accentColor)
    }

    @ViewBuilder
    func makeOption(
      _ option: Configuration.Option,
      _ tag: _Tag
    ) -> some View {
      switch tag {
      case let .tagged(tag):
        option
          .selectionGuide(tag == configuration.selection ? .selection : .center)
          .onTapGesture {
            withAnimation {
              configuration.selection = tag
            }
          }
      case .untagged:
        option
      }
    }
  }
}

extension VerticalAlignment {
  private enum SelectionAlignment : AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      return d[.bottom]
    }
  }
  static let selection = VerticalAlignment(SelectionAlignment.self)
}

extension View {
  func selectionGuide(_ guide: VerticalAlignment = .selection) -> some View {
    alignmentGuide(
      guide,
      computeValue: { d in d[VerticalAlignment.center] }
    )
  }
}
```
