/*
 * Copyright (c) Avito Tech LLC
 */

import CLTExtensions
import CLTLogging
import CLTLoggingModels
import DateProvider
import DI
import Dispatch
import EmceePluginModels
import FileSystem
import Foundation
import JSONStream
import SynchronousWaiter

/// Allows the plugin to track `PluginAppleTestEvent`s from the worker process.
public final class Plugin {
    public let logger: ContextualLogger
    private let jsonReaderQueue = DispatchQueue(label: "Plugin.jsonReaderQueue")
    private let jsonInputStream = BlockingArrayBasedJSONStream()
    private let jsonStreamAdapter: EmceePluginJSONStreamAdapter
    private var jsonStreamHasFinished = false
    private let eventReceiver: EventReceiver
    private let loggingSetup: LoggingSetup
    
    private let di: DependencyResolver
    
    public init(
        stderrVerbosity: Verbosity = .debug,
        detailedLogVerbosity: Verbosity = .trace,
        onNewEvent: @escaping (PluginAppleTestEvent) -> ()
    ) throws {
        self.di = DiMaker<EmceeModuleDependencies>.makeDi()
        self.loggingSetup = try di.resolve()
        self.logger = try loggingSetup.createLogger(
            stderrVerbosity: stderrVerbosity,
            detailedLogVerbosity: detailedLogVerbosity,
            kibanaVerbosity: .error
        )
        self.jsonStreamAdapter = EmceePluginJSONStreamAdapter(
            logger: logger,
            onNewEvent: onNewEvent
        )
        self.eventReceiver = EventReceiver(
            address: try PluginEnv.pluginSocket(),
            logger: logger,
            pluginIdentifier: try PluginEnv.pluginIdentifier()
        )
        
        streamPluginEvents()
    }
    
    private func streamPluginEvents() {
        parseJsonStream()
        readDataInBackground()
    }
    
    public func join() {
        try? SynchronousWaiter().waitWhile(description: "Wait for JSON stream to finish") {
            return jsonStreamHasFinished == false
        }
        loggingSetup.tearDown(timeout: 10)
    }
    
    private func parseJsonStream() {
        let jsonReader = JSONReader(inputStream: jsonInputStream, eventStream: jsonStreamAdapter)
        jsonReaderQueue.async {
            do {
                self.logger.trace("Starting JSON stream parser")
                try jsonReader.start()
            } catch {
                self.logger.error("JSON stream error: \(error)")
            }
            self.jsonStreamHasFinished = true
            self.logger.trace("JSON stream parser finished")
        }
    }
    
    private func readDataInBackground() {
        eventReceiver.onData = { data in
            self.onNewData(data: data)
        }
        
        eventReceiver.onError = { error in
            self.logger.error("\(error)")
            self.onEndOfData()
        }
        
        eventReceiver.onDisconnect = {
            self.onEndOfData()
        }
        
        eventReceiver.start()
    }
    
    private func onNewData(data: Data) {
        logger.trace("New data: \(data.count) bytes")
        jsonInputStream.append(data: data)
    }
    
    private func onEndOfData() {
        logger.trace("End of data")
        jsonInputStream.close()
    }
}
