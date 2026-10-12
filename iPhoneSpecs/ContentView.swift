import SwiftUI

struct ContentView: View {
    @State private var items = DeviceSnapshot.items()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        Image(systemName: "iphone.gen3")
                            .font(.system(size: 36))
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text("Your iPhone").font(.headline)
                            Text("Live device details").foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                }

                Section("Specifications") {
                    ForEach(items) { item in
                        LabeledContent(item.label) {
                            Text(item.value).multilineTextAlignment(.trailing)
                        }
                    }
                }

                Section {
                    Text("Some identifiers, including serial number and IMEI, are protected by iOS and cannot be read by ordinary apps.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("iPhone Specs")
            .toolbar {
                Button { items = DeviceSnapshot.items() } label: { Image(systemName: "arrow.clockwise") }
            }
        }
    }
}
