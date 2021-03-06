import Cocoa

class KubeContextMenu: NSObject {
  var kubeConfigReader: KubeConfigReader
  var yamlReader: YamlReader
  var statusItem: NSStatusItem
  var selectedKubeContext: NSMenuItem? = nil

  init(statusItem: NSStatusItem,
       yamlReader: YamlReader,
       kubeConfigReader: KubeConfigReader) {
    self.kubeConfigReader = kubeConfigReader
    self.yamlReader = yamlReader
    self.statusItem = statusItem
  }

  func refresh() {
    self.statusItem.menu?.removeAllItems()
    self.addContextNames()
    self.addMenuSeparator()
    self.addExitMenu()
  }

  func addContextNames() {
    let config = self.kubeConfigReader.read()
    let kubeConfig = self.yamlReader.loadKubeConfig(yaml: config)
    let contextNames: Array = kubeConfig.contextNames()
    if (contextNames.count <= 0) {
      let menuItem = NSMenuItem(title: "Kubernetes Context: None Available",
        action: nil,
        keyEquivalent: "")
      self.statusItem.menu?.addItem(menuItem)
      return
    }
    for contextName in contextNames {
      let menuItem = NSMenuItem(title: contextName,
        action: #selector(self.contextSelected),
        keyEquivalent: "")
      menuItem.target = self
      if kubeConfig.isCurrentContext(otherContextName: contextName) {
        menuItem.state = NSControl.StateValue.on
        self.selectedKubeContext = menuItem
      }
      self.statusItem.menu?.addItem(menuItem)
    }
  }

  func addMenuSeparator() {
    self.statusItem.menu?.addItem(NSMenuItem.separator())
  }

  @objc func exit() {
    NSApplication.shared.terminate(statusItem)
  }

  func addExitMenu() {
    let menuItem = NSMenuItem(title: "Exit",
      action: #selector(self.exit),
      keyEquivalent: "Q")
    menuItem.target = self
    statusItem.menu?.addItem(menuItem);
  }

  @objc func contextSelected(_ sender: NSMenuItem) {
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
