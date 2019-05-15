import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.squareLength)
    var kubeContextMenu:KubeContextMenu!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        self.statusItem.menu = menu
        self.statusItem.menu?.autoenablesItems = true
        self.statusItem.menu?.delegate = self
        self.statusItem.button?.image = NSImage(named:NSImage.Name("KubeClusterImage"))
        self.kubeContextMenu = KubeContextMenu(statusItem: self.statusItem)
    }

    func menuWillOpen(_ menu: NSMenu){
        self.kubeContextMenu.refresh()
    }
}
