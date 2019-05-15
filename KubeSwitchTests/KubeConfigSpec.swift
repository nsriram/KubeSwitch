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
        }

        describe("changeContext"){
            it("should change the current context"){
                let config:KubeConfig = KubeConfig(yamlContent: yamlContent)
                config.changeContext(newContext: "k8s-the-hard-way")
                expect(config.currentContext()).to(equal("k8s-the-hard-way"))
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
    }
}
