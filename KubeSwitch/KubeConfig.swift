class KubeConfig {
  var yamlContent: [String: Any]

  init(yamlContent: [String: Any]) {
    self.yamlContent = yamlContent
  }

  func currentContext() -> String {
    return (self.yamlContent["current-context"] != nil)
      ? self.yamlContent["current-context"] as! String : ""
  }

  func isCurrentContext(otherContextName: String) -> Bool {
    return otherContextName == self.currentContext()
  }

  func contexts() -> Array<AnyObject> {
    return (self.yamlContent["contexts"] != nil)
      ? self.yamlContent["contexts"] as! [AnyObject] : []
  }

  func contextNames() -> Array<String> {
    return self.contexts()
      .map {
        $0 as! [String: Any]
      }
      .map {
        $0["name"] as! String
      }
  }

  func changeContext(newContext: String) {
    self.yamlContent["current-context"] = newContext
  }
}
