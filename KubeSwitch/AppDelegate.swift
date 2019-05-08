import Cocoa
import Yams

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var currentMenuItem: NSMenuItem? = nil

    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength)
    let kubeConfig = KubeConfig()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        statusItem.menu = menu
        statusItem.button?.title = "KubeSwitch"
        self.addClusterNamesToMenu()
        statusItem.menu?.addItem(NSMenuItem.separator())
        self.addExitMenu()
    }

    @objc func clusterSelected(_ sender: NSMenuItem){
        do {
            let config = self.kubeConfig.read()
            var yamlContent = try Yams.load(yaml: config, .basic) as! [String: Any]
            let newContext = sender.title
            yamlContent["current-context"] = newContext
            let newYamlContent = try Yams.dump(object: yamlContent)
            self.kubeConfig.write(fileContent: newYamlContent)
            self.currentMenuItem?.state = NSControl.StateValue.off
            sender.state = NSControl.StateValue.on
            self.currentMenuItem = sender
        } catch {
            print(error)
        }
    }
    
    func addClusterNamesToMenu(){
        let config = self.kubeConfig.read()
        var loadedDictionary = [String: Any]()
        do {
            loadedDictionary = try Yams.load(yaml: config) as! [String : Any]
            let currentCluster = loadedDictionary["current-context"] as! String
            let clusters:Array = loadedDictionary["clusters"] as! [AnyObject]
            for cluster in clusters {
                let clusterName = cluster["name"] as! String
                let menuItem = NSMenuItem(title: clusterName,
                                          action: #selector(AppDelegate.clusterSelected),
                                          keyEquivalent: "")
                if clusterName == currentCluster {
                    menuItem.state = NSControl.StateValue.on
                    self.currentMenuItem = menuItem
                }
                statusItem.menu?.addItem(menuItem)
            }
        } catch {
            print("Could not load kube config dictionary")
            print(error)
        }
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
