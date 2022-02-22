import SwiftUI
import swiftui_betterpicker

struct ArrowPickerView: View {
  enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var title: String { rawValue.localizedCapitalized }
  }

  @State
  private var selection = DayOfWeek.tuesday

  @State
  private var isEnabled = true

  var body: some View {
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
