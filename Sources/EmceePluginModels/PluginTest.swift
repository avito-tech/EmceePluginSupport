/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

public final class PluginTest: CustomStringConvertible, Codable, Hashable {
    public let testName: PluginTestName
    public let tags: [String]
    public let caseId: UInt?
    
    public init(testName: PluginTestName, tags: [String], caseId: UInt?) {
        self.testName = testName
        self.tags = tags
        self.caseId = caseId
    }
    
    public var description: String {
        var components = [String]()
        
        components.append("\(testName)")
        if let caseId = caseId {
            components.append("case id: \(caseId)")
        }

        if !tags.isEmpty {
            components.append("tags: \(tags)")
        }
        
        let componentsJoined = components.joined(separator: ", ")
        
        return "<\(componentsJoined)>"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(testName)
        hasher.combine(tags)
        hasher.combine(caseId)
    }
    
    public static func == (lhs: PluginTest, rhs: PluginTest) -> Bool {
        return lhs.testName == rhs.testName &&
        lhs.tags == rhs.tags &&
        lhs.caseId == rhs.caseId
    }
}
