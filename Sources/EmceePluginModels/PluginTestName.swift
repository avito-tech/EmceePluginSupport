/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

/// Represents a test name in a format "ClassName/testMethodName".
public final class PluginTestName: CustomStringConvertible, Codable, Hashable {
    public let className: String
    public let methodName: String

    public init(className: String, methodName: String) {
        self.className = className
        self.methodName = methodName
    }
    
    public var stringValue: String {
        return className + "/" + methodName
    }
    
    public var description: String {
        return stringValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(className)
        hasher.combine(methodName)
    }
    
    public static func == (lhs: PluginTestName, rhs: PluginTestName) -> Bool {
        return lhs.methodName == rhs.methodName &&
        lhs.className == rhs.className
    }
}
