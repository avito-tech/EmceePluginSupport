/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

public final class PluginAppleTestContext: Codable, Hashable, CustomStringConvertible {
    /// Unique context ID  to distunguish one context from another.
    public let contextId: String
    
    /// Environment of the app and of the test.
    public let environment: [String: String]
    
    /// ID of a device which ran the test, e.g. simulator id.
    public let deviceId: String
    
    /// FQN of simulator device type, e.g. `com.apple.CoreSimulator.SimDeviceType.iPod-touch--7th-generation-`
    public let simDeviceType: String
    
    /// FQN of simulator runtime, e.g. `com.apple.CoreSimulator.SimRuntime.iOS-15-0`
    public let simRuntime: String
    
    /// Absolute path of a test runner working directory where it stores misc stuff.
    public let testRunnerWorkingDirectory: String
    
    /// Absolute path of a working directory where tests may store misc stuff. Plugin may post-process these artifacts.
    /// Tests get this path via `TestsWorkingDirectorySupport.envTestsWorkingDirectory` env.
    public let testsWorkingDirectory: String
    
    public init(
        contextId: String,
        environment: [String: String],
        deviceId: String,
        simDeviceType: String,
        simRuntime: String,
        testRunnerWorkingDirectory: String,
        testsWorkingDirectory: String
    ) {
        self.contextId = contextId
        self.environment = environment
        self.deviceId = deviceId
        self.simDeviceType = simDeviceType
        self.simRuntime = simRuntime
        self.testRunnerWorkingDirectory = testRunnerWorkingDirectory
        self.testsWorkingDirectory = testsWorkingDirectory
    }
    
    public var description: String {
        return "<\(type(of: self)): contextId: \(contextId) environment: \(environment), device: \(deviceId) \(simDeviceType) \(simRuntime), testRunnerWorkingDirectory: \(testRunnerWorkingDirectory), testsWorkingDirectory: \(testsWorkingDirectory)>"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(contextId)
        hasher.combine(environment)
        hasher.combine(deviceId)
        hasher.combine(simDeviceType)
        hasher.combine(simRuntime)
        hasher.combine(testRunnerWorkingDirectory)
        hasher.combine(testsWorkingDirectory)
    }
    
    public static func == (lhs: PluginAppleTestContext, rhs: PluginAppleTestContext) -> Bool {
        return lhs.contextId == rhs.contextId &&
        lhs.environment == rhs.environment &&
        lhs.deviceId == rhs.deviceId &&
        lhs.simDeviceType == rhs.simDeviceType &&
        lhs.simRuntime == rhs.simRuntime &&
        lhs.testRunnerWorkingDirectory == rhs.testRunnerWorkingDirectory &&
        lhs.testsWorkingDirectory == rhs.testsWorkingDirectory
    }
}
