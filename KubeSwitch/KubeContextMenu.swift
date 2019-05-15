import Cocoa

class KubeContextMenu: NSObject {
    var kubeConfigReader:KubeConfigReader
    var yamlReader:YamlReader
    var statusItem:NSStatusItem
    var selectedKubeContext: NSMenuItem? = nil

    init(statusItem: NSStatusItem) {
      self.kubeConfigReader = KubeConfigReader()
      self.yamlReader = YamlReader()
      self.statusItem = statusItem
    }
    
    func refresh(){
        self.statusItem.menu?.removeAllItems()
        self.statusItem.menu?.autoenablesItems = true
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
                                      action: #selector(self.contextSelected),
                                      keyEquivalent: "")
            menuItem.target = self
            if contextName == kubeConfig.currentContext() {
                menuItem.state = NSControl.StateValue.on
                self.selectedKubeContext = menuItem
            }
            self.statusItem.menu?.addItem(menuItem)
        }
    }
    
    func addMenuSeparator(){
        self.statusItem.menu?.addItem(NSMenuItem.separator())
    }
    
    @objc func exit(){
        NSApplication.shared.terminate(statusItem)
    }

    func addExitMenu(){
        let menuItem = NSMenuItem(title: "Exit",
                                 action: #selector(self.exit),
                                 keyEquivalent: "Q")
        menuItem.target = self
        statusItem.menu?.addItem(menuItem);
    }
    
    @objc func contextSelected(_ sender: NSMenuItem){
        let config = self.kubeConfigReader.read()
        let kubeConfig = self.yamlReader.loadKubeConfig(yaml: config)
        kubeConfig.changeContext(newContext: sender.title)
        let newYamlContent = self.yamlReader.dumpString(
            object: kubeConfig.yamlContent)
        self.kubeConfigReader.write(fileContent: newYamlContent)
        self.selectedKubeContext?.state = NSControl.StateValue.off
        sender.state = NSControl.StateValue.on
        self.selectedKubeContext = sender
    }
}
