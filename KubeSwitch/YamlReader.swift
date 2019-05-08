import Yams

class YamlReader {
    func loadKubeConfig(yaml: String) -> KubeConfig {
        do {
            let yamlContent = try Yams.load(yaml: yaml, .basic) as! [String: Any]
            return KubeConfig(yamlContent: yamlContent)
        } catch {
            print("[Error] Could not load yaml string as dictionary")
            print(error)
        }
        return KubeConfig(yamlContent: [:])
    }

    func dumpString(object: Any) -> String {
        var yamlString = ""
        do {
            yamlString = try Yams.dump(object: object)
        } catch {
            print("[Error] Could not convert yaml dictionary as string")
            print(error)
        }
        return yamlString
    }
}
