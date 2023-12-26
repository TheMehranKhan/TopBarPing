import SwiftUI

@main
struct TopBarPingApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            Text("Settings") // You can replace this with actual settings if needed
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var pingService: PingService!

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "Ping: --"
        pingService = PingService(statusItem: statusBarItem)
        pingService.startPinging()
    }
}
