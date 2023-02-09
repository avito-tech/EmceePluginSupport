/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

/// Sent from a worker to plugin.
public final class PluginTeardownRequest: Codable {
    public let tearDownAllowance: TimeInterval

    public init(
        tearDownAllowance: TimeInterval
    ) {
        self.tearDownAllowance = tearDownAllowance
    }
}
