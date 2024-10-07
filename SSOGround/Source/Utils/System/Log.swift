//
//  Log.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 06/10/24.
//

import Foundation

struct Log {
    static func info(_ message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        log(.info, message: message + footer(functionName: functionName, fileName: fileName, lineNumber: lineNumber))
    }

    static func error(_ message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        log(.error, message: message + footer(functionName: functionName, fileName: fileName, lineNumber: lineNumber))
    }

    static func warning(_ message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        log(.warning, message: message + footer(functionName: functionName, fileName: fileName, lineNumber: lineNumber))
    }

    static func debug(_ message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        log(.debug, message: message + footer(functionName: functionName, fileName: fileName, lineNumber: lineNumber))
    }

    static private func log(_ logType: LogType, message: String) {
        print(logType.emoji, message)
    }

    static private func footer(functionName: String, fileName: String, lineNumber: Int) -> String {
        let separator = "\n----------------------------\n"
        return "\(separator)Caller: \(functionName) \((fileName as NSString).lastPathComponent):\(lineNumber)\(separator)"
    }

    enum LogType {
        case info
        case error
        case warning
        case debug

        var emoji: String {
            switch self {
            case .info: return "ℹ️"
            case .error: return "❌"
            case .warning: return "⚠️"
            case .debug: return "💬"
            }
        }
    }
}
