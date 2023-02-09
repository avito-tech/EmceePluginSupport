/*
 * Copyright (c) Avito Tech LLC
 */

import CLTLogging
import Foundation
import JSONStream
import EmceePluginModels

final class EmceePluginJSONStreamAdapter: JSONReaderEventStream {
    private let logger: ContextualLogger
    private let decoder = JSONDecoder()
    private let onNewEvent: (PluginAppleTestEvent) -> ()
    
    public init(
        logger: ContextualLogger,
        onNewEvent: @escaping (PluginAppleTestEvent) -> ()
    ) {
        self.logger = logger
        self.onNewEvent = onNewEvent
    }
    
    func newArray(_ array: NSArray, data: Data) {
        logger.warning("JSON stream reader received an unexpected event: '\(data)'")
    }
    
    func newObject(_ object: NSDictionary, data: Data) {
        do {
            let event = try decoder.decode(PluginAppleTestEvent.self, from: data)
            onNewEvent(event)
        } catch {
            logger.error("Failed to decode plugin event: \(error), object: \(object)")
        }
    }
}
