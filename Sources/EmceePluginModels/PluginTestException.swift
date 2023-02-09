/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

public final class PluginTestException: Codable, CustomStringConvertible, Hashable {    
    public let reason: String
    public let filePathInProject: String
    public let lineNumber: Int32
    
    public init(reason: String, filePathInProject: String, lineNumber: Int32) {
        self.reason = reason
        self.filePathInProject = filePathInProject
        self.lineNumber = lineNumber
    }
    
    public var description: String {
        return "\(filePathInProject):\(lineNumber): \(reason)"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(reason)
        hasher.combine(filePathInProject)
        hasher.combine(lineNumber)
    }

    public static func == (lhs: PluginTestException, rhs: PluginTestException) -> Bool {
        return lhs.reason == rhs.reason &&
        lhs.filePathInProject == rhs.filePathInProject &&
        lhs.lineNumber == rhs.lineNumber
    }
}
