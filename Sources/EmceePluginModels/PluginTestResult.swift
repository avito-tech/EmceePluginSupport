/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

public final class PluginTestResult: Codable, CustomStringConvertible, Hashable {    
    public let test: PluginTest
    public let testRunResults: [PluginTestRunResult]
    
    public init(test: PluginTest, testRunResults: [PluginTestRunResult]) {
        self.test = test
        self.testRunResults = testRunResults
    }
    
    public static func lost(test: PluginTest) -> PluginTestResult {
        return PluginTestResult(test: test, testRunResults: [])
    }
    
    /// Indicates if runner was not able to execute the test.
    public var isLost: Bool {
        return testRunResults.isEmpty
    }
    
    public var containsSuccessfulRun: Bool {
        return !testRunResults.filter { $0.succeeded == true }.isEmpty
    }

    public var description: String {
        return "<\(type(of: self)) \(test): \(containsSuccessfulRun ? "succeeded" : "failed"), \(testRunResults.count) runs: \(testRunResults)>"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(test)
        hasher.combine(testRunResults)
    }
    
    public static func == (lhs: PluginTestResult, rhs: PluginTestResult) -> Bool {
        return lhs.test == rhs.test &&
        lhs.testRunResults == rhs.testRunResults
    }
}
