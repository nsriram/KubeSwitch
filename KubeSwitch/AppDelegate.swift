import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let kubeConfigReader = KubeConfigReader()
    let yamlReader = YamlReader()
    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength)
    var selectedKubeContext: NSMenuItem? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        self.statusItem.menu = menu
        self.statusItem.button?.title = "KubeSwitch"
        self.addContextNames()
        self.addMenuSeparator()
        self.addExitMenu()
    }
    
    func addContextNames(){
        let config = self.kubeConfigReader.read()
        let kubeConfig = self.yamlReader.loadKubeConfig(yaml: config)
        let contexts:Array = kubeConfig.contexts()
        for context in contexts {
            let contextName = context["name"] as! String
            let menuItem = NSMenuItem(title: contextName,
                                      action: #selector(AppDelegate.contextSelected),
                                      keyEquivalent: "")
            if contextName == kubeConfig.currentContext() {
                menuItem.state = NSControl.StateValue.on
                self.selectedKubeContext = menuItem
            }
            statusItem.menu?.addItem(menuItem)
        }
    }
    
    func addMenuSeparator(){
        self.statusItem.menu?.addItem(NSMenuItem.separator())
    }
    
    func addExitMenu(){
        let newMenu = NSMenuItem(title: "Exit",
                                 action: #selector(AppDelegate.exit),
                                 keyEquivalent: "Q")
        statusItem.menu?.addItem(newMenu);
    }
    
    @objc func contextSelected(_ sender: NSMenuItem){
        let config = self.kubeConfigReader.read()
        let kubeConfig = self.yamlReader.loadKubeConfig(yaml: config)
        kubeConfig.changeContext(newContext: sender.title)
        let newYamlContent = self.yamlReader.dumpString(object: kubeConfig.yamlContent)
        self.kubeConfigReader.write(fileContent: newYamlContent)
        self.selectedKubeContext?.state = NSControl.StateValue.off
        sender.state = NSControl.StateValue.on
        self.selectedKubeContext = sender
    }

    @objc func exit(){
        NSApplication.shared.terminate(statusItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}
