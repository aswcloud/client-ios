//
//  String+Hash.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/22.
//

import Foundation
import CryptoKit

extension String {
    func sha256() -> SHA256.Digest {
        return SHA256.hash(data: self.data(using: .utf8)!)
    }
    
    init(_ sha: SHA256.Digest) {
        self = sha.compactMap{ String(format: "%02x", $0) }.joined()
    }
    
    func ipPort() -> (ip:String, port:Int) {
        let ip: String
        let port: Int
        
        let split = self.split(separator: ":")
        
        if self.isEmpty {
            ip = ""
            port = 0
        }
        else if split.count == 1 {
            ip = String(split[0])
            port = 8088
        }else {
            ip = String(split[0])
            if let num = Int(split[1]) {
                port = num
            }else {
                port = 8088
            }
        }
        
        return (ip, port)
    }
}

