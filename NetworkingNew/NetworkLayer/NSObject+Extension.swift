//
//  NSObject+Extension.swift
//  NetworkingNew
//
//  Created by Alex Krzywicki on 12.10.2024.
//

import OSLog

extension NSObject {
    static func log(_ message: String, level: String = "INFO") {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        let logMessage = "\(timestamp) [\(level)] \(message)"
        os_log("%{public}@", log: .default, logMessage)
    }
}
