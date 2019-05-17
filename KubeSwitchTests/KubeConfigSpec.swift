import Quick
import Nimble

@testable import KubeSwitch

class KubeConfigSpec: QuickSpec {
    override func spec(){
        var yamlContent:[String : Any] = [:]

        beforeEach {
            yamlContent = [:]
            yamlContent["current-context"] = "minikube"
        }

        describe("currentContext"){
            it("should return the current context"){
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                expect(config.currentContext()).to(equal("minikube"))
            }

            it("should return empty string when no current context present") {
                yamlContent.removeValue(forKey: "current-context")
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                expect(config.currentContext()).to(equal(""))
            }
        }

        describe("changeContext"){
            it("should change the current context"){
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                config.changeContext(newContext: "k8s-the-hard-way")
                expect(config.currentContext()).to(equal("k8s-the-hard-way"))
            }
        }

        describe("isCurrentContext"){
            it("should return true when provided context matches current context"){
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                expect(config.isCurrentContext(otherContextName: "minikube")).to(beTrue())
            }

            it("should return false when provided context does not match current context"){
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                expect(config.isCurrentContext(otherContextName: "k8s-the-hard-way")).to(beFalse())
            }
        }

        describe("contexts"){
            it("should return all the contexts"){
                let context1 = ["cluster": "minikube"]
                let context2 = ["cluster": "k8s-the-hard-way"]
                let contexts:[Any] = [context1, context2]
                yamlContent["contexts"] = contexts
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                let actualContext:Array = config.contexts()
                expect(actualContext.count).to(equal(2))
            }
        }

        describe("contextNames"){
            it("should return all the context names"){
                let context1 = [
                    "context": ["cluster": "minikube", "user":"admin"],
                    "name":"minikube"] as [String:Any]
                let context2 = [
                    "context": ["cluster": "k8s-the-hard-way","user":"cluster-admin"],
                    "name":"k8s-the-hard-way"]  as [String:Any]
                let contexts:[Any] = [context1, context2]
                yamlContent["contexts"] = contexts
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)

                let actualContextNames = config.contextNames()

                expect(actualContextNames.count).to(equal(2))
                expect(actualContextNames).to(contain("minikube"))
                expect(actualContextNames).to(contain("k8s-the-hard-way"))
            }
        }
    }
}
