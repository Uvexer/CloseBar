import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel: TouchBarViewModel

    var body: some View {
        VStack {
            Text(viewModel.statusMessage)
                .padding()
                .font(.title)

            HStack {
                Button(action: {
                    viewModel.enableTouchBar()
                }) {
                    Text("Enable TouchBar")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    viewModel.disableTouchBar()
                }) {
                    Text("Disable TouchBar")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }
}
