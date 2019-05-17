import Quick
import Nimble
import Cuckoo

@testable import KubeSwitch

class KubeContextMenuSpec: QuickSpec {
    override func spec() {
        var mockKubeConfigReader: MockKubeConfigReader!
        var mockYamlReader: MockYamlReader!
        var statusItem:NSStatusItem!
        var contextMenu:KubeContextMenu!

        beforeEach() {
            mockKubeConfigReader = MockKubeConfigReader()
            mockYamlReader = MockYamlReader()
            statusItem = NSStatusBar.system.statusItem(
                withLength: NSStatusItem.squareLength)
            let menu = NSMenu()
            statusItem.menu = menu
            contextMenu = KubeContextMenu(
                statusItem: statusItem,
                yamlReader: mockYamlReader,
                kubeConfigReader: mockKubeConfigReader)
        }

        describe("addcontextNames") {
            var yamlContent:[String : Any]!

            beforeEach() {
                let context1 = [
                    "context": ["cluster": "minikube", "user":"admin"],
                    "name":"minikube"] as [String:Any]
                let context2 = [
                    "context": ["cluster": "k8s-the-hard-way","user":"cluster-admin"],
                    "name":"k8s-the-hard-way"]  as [String:Any]
                let contexts:[Any] = [context1, context2]
                yamlContent = [:]
                yamlContent["contexts"] = contexts
            }

            it("should add context names from kubeconfig yaml to status menu"){
                let someYaml = "apiVersion: v1"
                let kubeConfig:KubeConfig = KubeConfig(yamlContent: yamlContent)

                stub(mockKubeConfigReader) { stub in
                    when(stub.read()).thenReturn(someYaml)
                }
                stub(mockYamlReader) { stub in
                    when(stub.loadKubeConfig(yaml: someYaml)).thenReturn(kubeConfig)
                }

                contextMenu.addContextNames()

                expect(statusItem.menu?.numberOfItems).to(equal(2))
                let menuItem1:NSMenuItem? = statusItem.menu?.item(at: 0)
                expect(menuItem1?.title).to(equal("minikube"))
                expect(menuItem1?.state).to(equal(NSControl.StateValue.off))

                let menuItem2:NSMenuItem? = statusItem.menu?.item(at: 1)
                expect(menuItem2?.title).to(equal("k8s-the-hard-way"))
                expect(menuItem2?.state).to(equal(NSControl.StateValue.off))
            }

            it("should set current context read from kubeconfig yaml to status menu"){
                let someYaml = "apiVersion: v1"
                yamlContent["current-context"] = "k8s-the-hard-way"
                let kubeConfig:KubeConfig = KubeConfig(yamlContent: yamlContent)

                stub(mockKubeConfigReader) { stub in
                    when(stub.read()).thenReturn(someYaml)
                }
                stub(mockYamlReader) { stub in
                    when(stub.loadKubeConfig(yaml: someYaml)).thenReturn(kubeConfig)
                }

                contextMenu.addContextNames()

                expect(statusItem.menu?.numberOfItems).to(equal(2))
                let menuItem1:NSMenuItem? = statusItem.menu?.item(at: 0)
                expect(menuItem1?.title).to(equal("minikube"))
                expect(menuItem1?.state).to(equal(NSControl.StateValue.off))

                let menuItem2:NSMenuItem? = statusItem.menu?.item(at: 1)
                expect(menuItem2?.title).to(equal("k8s-the-hard-way"))
                expect(menuItem2?.state).to(equal(NSControl.StateValue.on))
            }
        }

        describe("addMenuSeparator") {
            it("should add menu separator") {
                contextMenu.addMenuSeparator()

                expect(statusItem.menu?.numberOfItems).to(equal(1))
                expect(statusItem.menu?.item(at: 0)?.isSeparatorItem).to(beTrue())
            }
        }
    }
}
