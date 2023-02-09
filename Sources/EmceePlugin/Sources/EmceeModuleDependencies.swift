import CLTLogging
import DateProvider
import DI
import FileSystem

public final class EmceeModuleDependencies: ModuleDependencies, InitializableWithNoArguments {
    public init() {}
    
    public func otherModulesDependecies() -> [ModuleDependencies] {
        [
            DateProviderModuleDependencies(),
            FileSystemModuleDependencies(),
        ]
    }
    
    public func registerDependenciesOfCurrentModule(di: DependencyRegisterer) {
        di.register(type: LoggingSetup.self) { di in
            try LoggingSetup(
                dateProvider: di.resolve(),
                fileSystem: di.resolve(),
                logDomainName: "EmceePlugins"
            )
        }
    }
}
