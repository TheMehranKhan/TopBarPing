import Foundation
import AppKit

class PingService {
    var statusItem: NSStatusItem
    var timer: Timer?
    
    init(statusItem: NSStatusItem) {
        self.statusItem = statusItem
    }

    func startPinging() {
        // Set up a repeating timer to ping every X seconds
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.pingServer(url: URL(string: "http://google.com")!) // Replace with your server URL
        }
        timer?.fire() // Start pinging immediately
    }

    func pingServer(url: URL) {
        let startTime = Date()
        URLSession.shared.dataTask(with: url) { _, _, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.statusItem.button?.title = "Ping: Error"
                    return
                }
                let duration = Date().timeIntervalSince(startTime)
                self.statusItem.button?.title = String(format: "Ping: %.2fms", duration * 1000)
            }
        }.resume()
    }
}
