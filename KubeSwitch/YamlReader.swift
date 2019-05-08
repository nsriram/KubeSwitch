import Yams

class YamlReader {
    func loadDictionary(yaml: String) -> [String: Any] {
        var yamlContent: [String: Any] = [:]
        do {
            yamlContent = try Yams.load(yaml: yaml, .basic) as! [String: Any]
        } catch {
            print("[Error] Could not load yaml string as dictionary")
            print(error)
        }
        return yamlContent
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
