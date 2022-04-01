//
//  JWTClaim.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/25.
//

import Foundation
import SwiftJWT
//atClaims["authorized"] = true
//atClaims["user_id"] = uuid
//atClaims["iat"] = time.Now().Unix()
//atClaims["exp"] = time.Now().Add(time.Minute * 15).Unix()

struct TokenMessage: Claims {
    let iat: Int64
    let exp: Int64
    let user_id: String
    let authorized: Bool
    let name: String?
    let type: String
}
