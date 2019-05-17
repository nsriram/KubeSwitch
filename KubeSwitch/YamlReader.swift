import Yams
import os.log

class YamlReader {
  func loadKubeConfig(yaml: String) -> KubeConfig {
    do {
      let readYaml = try Yams.load(yaml: yaml, .basic)
      let yamlContent = readYaml != nil ? readYaml as! [String: Any] : [:]
      return KubeConfig(yamlContent: yamlContent)
    } catch {
      os_log("Could not load yaml string as dictionary", type: .error)
      let errorDetails = "\(error)"
      os_log("%@", errorDetails)
    }
    return KubeConfig(yamlContent: [:])
  }

  func dumpString(object: Any) -> String {
    var yamlString = ""
    do {
      yamlString = try Yams.dump(object: object)
    } catch {
      os_log("Could not convert yaml dictionary as string", type: .error)
      let errorDetails = "\(error)"
      os_log("%@", errorDetails)
    }
    return yamlString
  }
}
