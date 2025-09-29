/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

/// A result of a single test run.
public struct PluginTestRunResult: Codable, CustomStringConvertible, Hashable {
    public let startTime: TimeInterval
    public let duration: TimeInterval
    public let succeeded: Bool
    public let exceptions: [PluginTestException]
    public let logs: [String]
    public let status: PluginTestRunStatus

    public var finishTime: TimeInterval {
        return startTime + duration
    }

    public init(
        startTime: TimeInterval,
        duration: TimeInterval,
        succeeded: Bool,
        exceptions: [PluginTestException],
        logs: [String],
        status: PluginTestRunStatus,
    ) {
        self.succeeded = succeeded
        self.exceptions = exceptions
        self.logs = logs
        self.startTime = startTime
        self.duration = duration
        self.status = status
    }
    
    public var description: String {
        var result: [String] = ["\(type(of: self)) \(succeeded ? "succeeded" : "failed")"]
        result += ["started at \(startTime)"]
        result += ["duration \(duration)"]
        if !exceptions.isEmpty {
            result += ["\(exceptions.count) exceptions"]
        }
        return "<\(result.joined(separator: ", "))>"
    }
}

public enum PluginTestRunStatus: String, Codable, CustomStringConvertible {
    case success
    case failure
    case skipped
    case broken

    public var description: String { rawValue }
}
