import SwiftUI
import swiftui_betterpicker

struct GridPickerView: View {
  enum Colors: CaseIterable {
    case red
    case blue
    case green
    case purple
    case yellow
    case pink

    var color: Color {
      switch self {
      case .red: return .red
      case .purple: return .purple
      case .green: return .green
      case .yellow: return .yellow
      case .blue: return .blue
      case .pink: return .pink
      }
    }
  }

  @State
  private var selection = Colors.red

  var body: some View {
    _Picker("Grid", selection: $selection) {
      ForEach(Colors.allCases, id: \.self) {
        $0.color.tag($0)
      }
    }
    .pickerStyle(.grid)
    .navigationTitle("Grid Picker")
  }
}

extension _PickerStyle where Self == GridPickerStyle {
  static var grid: GridPickerStyle { .init() }
}

struct GridPickerStyle: _PickerStyle {
  func makeBody(configuration: Configuration<Self._SelectionValue>) -> some View {
    Style(configuration: configuration)
  }

  struct Style: View {
    let configuration: Configuration<SelectionValue>

    var body: some View {
      LazyVGrid(columns: [.init(), .init(), .init()]) {
        configuration.content {
          .init(makeOption($0))
        }
      }
    }

    @ViewBuilder
    func makeOption(
      _ option: Configuration<SelectionValue>.Option
    ) -> some View {
      switch option.tag {
      case let .tagged(tag):
        Button {
          withAnimation {
            configuration.selection = tag
          }
        } label: {
          option
            .aspectRatio(1, contentMode: .fit)
            .overlay {
              if configuration.selection == tag {
                Image(systemName: "checkmark.circle.fill")
                  .imageScale(.large)
                  .foregroundColor(.primary)
                  .blendMode(.luminosity)
              }
            }
        }
        .buttonStyle(.plain)
      case .untagged:
        EmptyView()
      }
    }
  }
}
