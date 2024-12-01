import SwiftUI

@main
struct CloseBarApp: App {
    @StateObject private var viewModel = TouchBarViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        
        MenuBarExtra("CloseBar" ,systemImage: "ladybug") {
            Button("Enable") {
                viewModel.enableTouchBar()
            }
            .keyboardShortcut("1", modifiers: .command)
            
            Button("Disable") {
                viewModel.disableTouchBar()
            }
            .keyboardShortcut("2", modifiers: .command)
        }
    }
}
