import SwiftUI
import swiftui_betterpicker

struct ListPickerView: View {
  enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var title: String { rawValue.localizedCapitalized }
  }

  @State
  private var selection = DayOfWeek.tuesday

  var body: some View {
    List {
      let title: LocalizedStringKey = "List Picker"
      _Picker(title, selection: $selection) {
        ForEach(DayOfWeek.allCases, id: \.self) {
          Text($0.title).tag($0)
        }
      }
      .pickerStyle(.list(title: title))
    }
    .navigationTitle(selection.title)
  }
}

extension _PickerStyle where Self == ListPickerStyle {
  static func list(title: LocalizedStringKey) -> ListPickerStyle { .init(title: title) }
}

struct ListPickerStyle: _PickerStyle {
  let title: LocalizedStringKey

  func makeBody(configuration: Configuration<Self.SelectionValue>) -> some View {
    Style(configuration: configuration, title: title)
  }

  struct Style: View {
    let configuration: Configuration<SelectionValue>
    let title: LocalizedStringKey

    var body: some View {
      NavigationLink {
        ListView(configuration: configuration, title: title)
      } label: {
        HStack {
          configuration.label
          Spacer()
          configuration.content { view, tag in
              .init(makeBadge(view, tag))
          }
        }
      }
    }

    @ViewBuilder
    func makeBadge(_ option: Configuration<SelectionValue>.Option, _ tag: _Tag) -> some View {
      switch tag {
      case let .tagged(tag):
        if tag == configuration.selection {
          option
            .font(.callout)
            .foregroundStyle(.secondary)
        } else {
          EmptyView()
        }
      case .untagged:
        EmptyView()
      }
    }
  }

  struct ListView: View {
    @Environment(\.dismiss)
    private var dismiss

    let configuration: Configuration<SelectionValue>
    let title: LocalizedStringKey

    var body: some View {
      List {
        configuration.content { view, tag in
            .init(makeOption(view, tag))
        }
      }
      .navigationTitle(title)
    }

    @ViewBuilder
    func makeOption(
      _ option: Configuration<SelectionValue>.Option,
      _ tag: _Tag
    ) -> some View {
      switch tag {
      case let .tagged(tag):
        Button {
          configuration.selection = tag
          Task {
            try? await Task.sleep(nanoseconds: 100_000_000)
            DispatchQueue.main.async {
              dismiss()
            }
          }
        } label: {
          HStack {
            option
              .foregroundColor(.primary)
            Spacer()
            if tag == configuration.selection {
              Image(systemName: "checkmark")
            }
          }
        }
      case .untagged:
        EmptyView()
      }
    }
  }
}
