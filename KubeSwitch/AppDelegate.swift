import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        statusItem.menu = menu
        statusItem.button?.title = "KubeSwitch"
        self.addExitMenu()
    }
    
    @objc func exit(){
        NSApplication.shared.terminate(statusItem)
    }
    
    func addExitMenu(){
        let newMenu = NSMenuItem(title: "Exit",
                                 action: #selector(AppDelegate.exit),
                                 keyEquivalent: "Q")
        statusItem.menu?.addItem(newMenu);
        statusItem.menu?.addItem(NSMenuItem.separator())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}
