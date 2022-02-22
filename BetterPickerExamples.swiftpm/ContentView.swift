import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Arrow") {
          ArrowPickerView()
        }
        NavigationLink("List") {
          ListPickerView()
        }
        NavigationLink("Grid") {
          GridPickerView()
        }
      }
      .navigationTitle("BetterPicker")
    }
    .navigationViewStyle(.stack)
  }
}
