// MARK: - Mocks generated from file: KubeSwitch/KubeConfigReader.swift at 2019-05-17 12:33:25 +0000


import Cuckoo
@testable import KubeSwitch

import Cocoa


 class MockKubeConfigReader: KubeConfigReader, Cuckoo.ClassMock {
     typealias MocksType = KubeConfigReader
     typealias Stubbing = __StubbingProxy_KubeConfigReader
     typealias Verification = __VerificationProxy_KubeConfigReader

    private var __defaultImplStub: KubeConfigReader?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

     func enableDefaultImplementation(_ stub: KubeConfigReader) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     override func read()  -> String {
        
            return cuckoo_manager.call("read() -> String",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    super.read()
                    ,
                defaultCall: __defaultImplStub!.read())
        
    }
    
    
    
     override func write(fileContent: String)  {
        
            return cuckoo_manager.call("write(fileContent: String)",
                parameters: (fileContent),
                escapingParameters: (fileContent),
                superclassCall:
                    
                    super.write(fileContent: fileContent)
                    ,
                defaultCall: __defaultImplStub!.write(fileContent: fileContent))
        
    }
    

	 struct __StubbingProxy_KubeConfigReader: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func read() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockKubeConfigReader.self, method: "read() -> String", parameterMatchers: matchers))
	    }
	    
	    func write<M1: Cuckoo.Matchable>(fileContent: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: fileContent) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockKubeConfigReader.self, method: "write(fileContent: String)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_KubeConfigReader: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func read() -> Cuckoo.__DoNotUse<String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("read() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func write<M1: Cuckoo.Matchable>(fileContent: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: fileContent) { $0 }]
	        return cuckoo_manager.verify("write(fileContent: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class KubeConfigReaderStub: KubeConfigReader {
    

    

    
     override func read()  -> String {
        return DefaultValueRegistry.defaultValue(for: String.self)
    }
    
     override func write(fileContent: String)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}


// MARK: - Mocks generated from file: KubeSwitch/YamlReader.swift at 2019-05-17 12:33:25 +0000


import Cuckoo
@testable import KubeSwitch

import Yams


 class MockYamlReader: YamlReader, Cuckoo.ClassMock {
     typealias MocksType = YamlReader
     typealias Stubbing = __StubbingProxy_YamlReader
     typealias Verification = __VerificationProxy_YamlReader

    private var __defaultImplStub: YamlReader?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

     func enableDefaultImplementation(_ stub: YamlReader) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     override func loadKubeConfig(yaml: String)  -> KubeConfig {
        
            return cuckoo_manager.call("loadKubeConfig(yaml: String) -> KubeConfig",
                parameters: (yaml),
                escapingParameters: (yaml),
                superclassCall:
                    
                    super.loadKubeConfig(yaml: yaml)
                    ,
                defaultCall: __defaultImplStub!.loadKubeConfig(yaml: yaml))
        
    }
    
    
    
     override func dumpString(object: Any)  -> String {
        
            return cuckoo_manager.call("dumpString(object: Any) -> String",
                parameters: (object),
                escapingParameters: (object),
                superclassCall:
                    
                    super.dumpString(object: object)
                    ,
                defaultCall: __defaultImplStub!.dumpString(object: object))
        
    }
    

	 struct __StubbingProxy_YamlReader: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func loadKubeConfig<M1: Cuckoo.Matchable>(yaml: M1) -> Cuckoo.ClassStubFunction<(String), KubeConfig> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: yaml) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockYamlReader.self, method: "loadKubeConfig(yaml: String) -> KubeConfig", parameterMatchers: matchers))
	    }
	    
	    func dumpString<M1: Cuckoo.Matchable>(object: M1) -> Cuckoo.ClassStubFunction<(Any), String> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: object) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockYamlReader.self, method: "dumpString(object: Any) -> String", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_YamlReader: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func loadKubeConfig<M1: Cuckoo.Matchable>(yaml: M1) -> Cuckoo.__DoNotUse<KubeConfig> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: yaml) { $0 }]
	        return cuckoo_manager.verify("loadKubeConfig(yaml: String) -> KubeConfig", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func dumpString<M1: Cuckoo.Matchable>(object: M1) -> Cuckoo.__DoNotUse<String> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: object) { $0 }]
	        return cuckoo_manager.verify("dumpString(object: Any) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class YamlReaderStub: YamlReader {
    

    

    
     override func loadKubeConfig(yaml: String)  -> KubeConfig {
        return DefaultValueRegistry.defaultValue(for: KubeConfig.self)
    }
    
     override func dumpString(object: Any)  -> String {
        return DefaultValueRegistry.defaultValue(for: String.self)
    }
    
}

