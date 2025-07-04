//
//  AESCrypto.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 04/07/25.
//

import Foundation
import CryptoKit

enum AESCrypto {
    
    static func encrypt(_ text: String, _ key: SymmetricKey) throws -> Data {
        let data = Data(text.utf8)
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
    static func decrypt(_ encryptedData: Data, _ key: SymmetricKey) throws -> String {
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        let decryptData = try AES.GCM.open(sealedBox, using: key)
        return String(decoding: decryptData, as: UTF8.self)
    }
}
