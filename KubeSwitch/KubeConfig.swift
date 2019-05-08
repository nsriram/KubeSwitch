class KubeConfig {
    var yamlContent: [String: Any]

    init(yamlContent: [String: Any]) {
      self.yamlContent = yamlContent
    }

    func currentCluster() -> String {
      return self.yamlContent["current-context"] as! String
    }

    func clusters() -> Array<AnyObject> {
      return self.yamlContent["clusters"] as! [AnyObject]
    }

    func changeContext(newContext: String){
      self.yamlContent["current-context"] = newContext
    }
}
