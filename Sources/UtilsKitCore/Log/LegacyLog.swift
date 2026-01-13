//
//  LegacyLog.swift
//  UtilsKit
//
//  Created by Elora Delpierre on 13/01/2026.
//

import Foundation
import OSLog

// MARK: - Legacy API surface (for older apps)

public protocol LogType {
    var prefix: String { get }
}

public enum DefaultLogType: LogType {
    case data
    case decode
    case network
    case coredata
    case file
    case user
    case security
    case notification
    case camera
    case photo
    case biometry
    case tag
    case refresh
    case map
    case spotlight
    case navigation
    case debug
    case custom(String)

    public var prefix: String {
        switch self {
        case .data: return "🗄"
        case .decode: return "🔤"
        case .network: return "📶"
        case .coredata: return "💾"
        case .file: return "📃"
        case .security: return "🗝"
        case .user: return "👤"
        case .notification: return "🛎"
        case .camera: return "📹"
        case .photo: return "📷"
        case .biometry: return "🛡"
        case .tag: return "🏷"
        case .refresh: return "🔄"
        case .map: return "🗺"
        case .spotlight: return "🔍"
        case .navigation: return "⛳️"
        case .debug: return "🕹"
        case .custom(let p): return p
        }
    }
}

public enum NetworkLogType: LogType {
    case sending(String)
    case success(String)
    case error(String)

    public var prefix: String {
        switch self {
        case .sending(let type): return "➡️ \(type)"
        case .success(let type): return "✅ \(type)"
        case .error(let type): return "❌ \(type)"
        }
    }
}

// MARK: - Legacy functions

public func debug(_ object: Any? = nil, error: Error? = nil) {
    showLog(DefaultLogType.debug, object, error: error)
}

public func log(_ type: any LogType, _ object: String? = nil, error: Error? = nil) {
    showLog(type, object, error: error)
}

public func log(_ type: any LogType, _ object: Any? = nil, error: Error? = nil) {
    showLog(type, object, error: error)
}

public func log(_ type: DefaultLogType, _ object: Any? = nil, error: Error? = nil) {
    showLog(type, object, error: error)
}

// MARK: - Implementation

private func showLog(_ type: any LogType, _ object: Any? = nil, error: Error? = nil) {
    #if DEBUG
    let prefix = type.prefix

    let message: String
    if let object {
        message = String(describing: object)
    } else {
        message = ""
    }

    let logger: Logger
    if let defaultType = type as? DefaultLogType {
        logger = loggerFor(defaultType)
    } else {
        logger = Logger(subsystem: "UtilsKit", category: "Custom")
    }

    if let error {
        logger.fault("\(prefix) - \(message) - \(error.localizedDescription)")
    } else {
        logger.debug("\(prefix) - \(message)")
    }
    #endif
}

private func loggerFor(_ type: DefaultLogType) -> Logger {
    switch type {
    case .data:         return .data
    case .decode:       return .decode
    case .biometry:     return .biometry
    case .file:         return .file
    case .navigation:   return .navigation
    case .debug:        return Logger(subsystem: "UtilsKit", category: "Debug")
    case .network:      return Logger(subsystem: "UtilsKit", category: "Network")
    case .coredata:     return Logger(subsystem: "UtilsKit", category: "CoreData")
    case .user:         return Logger(subsystem: "UtilsKit", category: "User")
    case .security:     return Logger(subsystem: "UtilsKit", category: "Security")
    case .notification: return Logger(subsystem: "UtilsKit", category: "Notification")
    case .camera:       return Logger(subsystem: "UtilsKit", category: "Camera")
    case .photo:        return Logger(subsystem: "UtilsKit", category: "Photo")
    case .tag:          return Logger(subsystem: "UtilsKit", category: "Tag")
    case .refresh:      return Logger(subsystem: "UtilsKit", category: "Refresh")
    case .map:          return Logger(subsystem: "UtilsKit", category: "Map")
    case .spotlight:    return Logger(subsystem: "UtilsKit", category: "Spotlight")
    case .custom:       return Logger(subsystem: "UtilsKit", category: "Custom")
    }
}
