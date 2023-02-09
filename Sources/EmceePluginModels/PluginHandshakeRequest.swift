/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

/// Sent from a plugin to a worker.
public final class PluginHandshakeRequest: Codable {
    public let pluginIdentifier: String

    public init(pluginIdentifier: String) {
        self.pluginIdentifier = pluginIdentifier
    }
}
