//
//  String+Extensions.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import CryptoKit
import CommonCrypto

public extension String {
    var md5: String {
        let data = self.data(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        _ = data!.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data!.count), &digest)
        }

        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
}
