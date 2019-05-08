import Cocoa

class KubeConfig {
    let kubeConfigFile = "\(NSHomeDirectory())/.kube/config"

    func read() -> String {
        var contents = ""
        do {
            contents = try String(contentsOfFile: self.kubeConfigFile)
        } catch{
            print("Could not load \(self.kubeConfigFile)")
        }
        return contents
    }
    
    func write(fileContent: String) {
        do {
            try fileContent.write(toFile: self.kubeConfigFile,
                                     atomically: true,
                                     encoding: .utf8)
        } catch {
            print(error)
        }
    }
}
