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
}

