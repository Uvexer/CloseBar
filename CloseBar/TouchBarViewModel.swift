import SwiftUI

class TouchBarViewModel: ObservableObject {
    @Published var statusMessage: String = "Press a button to enable or disable the Touch Bar"
    
    func enableTouchBar() {
        statusMessage = "Enabling Touch Bar..."
        
        runShellCommand("defaults delete com.apple.touchbar.agent PresentationModeGlobal")
        runShellCommand("defaults write com.apple.touchbar.agent PresentationModeFnModes '<dict><key>app</key><string>fullControlStrip</string><key>appWithControlStrip</key><string>fullControlStrip</string><key>fullControlStrip</key><string>app</string></dict>'")
        
        runShellCommand("launchctl load /System/Library/LaunchAgents/com.apple.controlstrip.plist")
        runShellCommand("launchctl load /System/Library/LaunchAgents/com.apple.touchbar.agent.plist")
        runShellCommand("launchctl load /System/Library/LaunchDaemons/com.apple.touchbar.user-device.plist")
        
        runShellCommand("pkill 'ControlStrip'")
        runShellCommand("pkill 'Touch Bar agent'")
        runShellCommand("pkill Dock")
        
        statusMessage = "Touch Bar Enabled"
    }

    func disableTouchBar() {
        statusMessage = "Disabling Touch Bar..."
        
        runShellCommand("defaults write com.apple.touchbar.agent PresentationModeGlobal -string fullControlStrip")
        
        runShellCommand("launchctl unload /System/Library/LaunchAgents/com.apple.controlstrip.plist")
        runShellCommand("launchctl unload /System/Library/LaunchAgents/com.apple.touchbar.agent.plist")
        runShellCommand("launchctl unload /System/Library/LaunchDaemons/com.apple.touchbar.user-device.plist")

        runShellCommand("pkill 'ControlStrip'")
        runShellCommand("pkill 'Touch Bar agent'")
        runShellCommand("pkill Dock")
        
        statusMessage = "Touch Bar Disabled"
    }

    private func runShellCommand(_ command: String) {
        let process = Process()
        let pipe = Pipe()

        process.executableURL = URL(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", command]
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            print("Error running shell command: \(error)")
        }
    }
}
