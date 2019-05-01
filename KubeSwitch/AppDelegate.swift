import Cocoa
import Yams

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        statusItem.menu = menu
        statusItem.button?.title = "KubeSwitch"
        self.addClusterNamesToMenu()
        self.addExitMenu()
    }

    @objc func noOperation(){
    }

    func addClusterNamesToMenu(){
        let config = kubeConfig()
        var loadedDictionary = [String: Any]()
        do {
            loadedDictionary = try Yams.load(yaml: config) as! [String : Any]
            let currentClusterName = loadedDictionary["current-context"] as! String
            let clusters:Array = loadedDictionary["clusters"] as! [AnyObject]
            for cluster in clusters {
                let clusterName = cluster["name"] as! String
                let menuItem = NSMenuItem(title: clusterName,
                                          action: #selector(AppDelegate.noOperation),
                                          keyEquivalent: "")
                if clusterName == currentClusterName {
                    menuItem.state = NSOnState
                }
                statusItem.menu?.addItem(menuItem)
            }
        } catch {
            print("Could not load kube config dictionary")
        }
    }
    
    func kubeConfig() -> String {
        let kubeConfigFile = "\(NSHomeDirectory())/.kube/config"
        var contents = ""
        do {
            contents = try String(contentsOfFile: kubeConfigFile)
        } catch{
            print("Could not load \(kubeConfigFile)")
        }
        return contents
    }
    
    @objc func exit(){
        NSApplication.shared().terminate(statusItem)
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
