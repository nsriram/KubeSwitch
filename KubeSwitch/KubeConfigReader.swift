import Cocoa
import os.log

class KubeConfigReader {
  let kubeConfigFile = "\(NSHomeDirectory())/.kube/config"

  func read() -> String {
    var contents = ""
    do {
      contents = try String(contentsOfFile: self.kubeConfigFile)
    } catch {
      let errorInfo = "Could not load \(self.kubeConfigFile)"
      os_log("%@", errorInfo)
      let errorDetails = "\(error)"
      os_log("%@", errorDetails)
    }
    return contents
  }

  func write(fileContent: String) {
    do {
      try fileContent.write(toFile: self.kubeConfigFile,
        atomically: true,
        encoding: .utf8)
    } catch {
      let errorInfo = "Could not load write to \(self.kubeConfigFile)"
      os_log("%@", errorInfo)
      let errorDetails = "\(error)"
      os_log("%@", errorDetails)
    }
  }
}
