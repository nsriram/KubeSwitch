import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let kubeConfig = KubeConfig()
    let yamlReader = YamlReader()
    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength)
    var selectedKubeContext: NSMenuItem? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        self.statusItem.menu = menu
        self.statusItem.button?.title = "KubeSwitch"
        self.addClusterNamesToMenu()
        self.addMenuSeparator()
        self.addExitMenu()
    }
    
    func addClusterNamesToMenu(){
        let config = self.kubeConfig.read()
        var yamlContent = self.yamlReader.loadDictionary(yaml: config)
        let currentCluster = yamlContent["current-context"] as! String
        let clusters:Array = yamlContent["clusters"] as! [AnyObject]
        for cluster in clusters {
            let clusterName = cluster["name"] as! String
            let menuItem = NSMenuItem(title: clusterName,
                                      action: #selector(AppDelegate.clusterSelected),
                                      keyEquivalent: "")
            if clusterName == currentCluster {
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
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }

    @objc func clusterSelected(_ sender: NSMenuItem){
        let config = self.kubeConfig.read()
        var yamlContent = self.yamlReader.loadDictionary(yaml: config)
        let selectedContext = sender.title
        yamlContent["current-context"] = selectedContext
        let newYamlContent = self.yamlReader.dumpString(object: yamlContent)
        self.kubeConfig.write(fileContent: newYamlContent)
        self.selectedKubeContext?.state = NSControl.StateValue.off
        sender.state = NSControl.StateValue.on
        self.selectedKubeContext = sender
    }

    @objc func exit(){
        NSApplication.shared.terminate(statusItem)
    }
}
