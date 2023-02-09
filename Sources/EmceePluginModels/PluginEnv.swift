/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation

public final class PluginEnv {
    public static let pluginSocketEnv = "EMCEE_PLUGIN_SOCKET"
    public static let pluginIdentifierEnv = "EMCEE_PLUGIN_ID"
    
    public enum PluginEnvError: Error {
        case pluginSocketEnvIsNotDefined
        case pluginIdentifierEnvIsNotDefined
    }
    
    public static func pluginSocket() throws -> String {
        guard let value = ProcessInfo.processInfo.environment[pluginSocketEnv] else {
            throw PluginEnvError.pluginSocketEnvIsNotDefined
        }
        return value
    }
    
    public static func pluginIdentifier() throws -> String {
        guard let value = ProcessInfo.processInfo.environment[pluginIdentifierEnv] else {
            throw PluginEnvError.pluginIdentifierEnvIsNotDefined
        }
        return value
    }
}
