//
//  JWTDecoder.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 01/10/24.
//

import Foundation

struct JWTDecoder {
    enum DecodeErrors: Error {
        case badToken
        case other
    }

    static func decode(jwtToken jwt: String) throws -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        return try decodeJWTPart(segments[1])
    }

    private static func base64Decode(_ base64: String) throws -> Data {
        let base64 = base64
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
        guard let decoded = Data(base64Encoded: padded) else {
            throw DecodeErrors.badToken
        }
        return decoded
    }

    private static func decodeJWTPart(_ value: String) throws -> [String: Any] {
        let bodyData = try base64Decode(value)
        let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
        guard let payload = json as? [String: Any] else {
            throw DecodeErrors.other
        }
        return payload
    }
}
