//
//  KeychainHelper.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 09/07/25.
//

import Foundation
import CryptoKit
import Security

class KeychainHelper {
    static let keychainService = "com.sharad.Simply-Notes"
    static let encryptionKeyKey = "vault_encryption_key"

    static func saveEncryptionKey(_ key: SymmetricKey) {
        let tag = encryptionKeyKey
        let keyData = key.withUnsafeBytes { Data($0) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecValueData as String: keyData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    static func loadEncryptionKey() -> SymmetricKey? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: encryptionKeyKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data else {
            return nil
        }

        return SymmetricKey(data: data)
    }

    static func generateAndStoreKeyIfNeeded() -> SymmetricKey {
        if let existing = loadEncryptionKey() {
            return existing
        } else {
            let key = SymmetricKey(size: .bits256)
            saveEncryptionKey(key)
            return key
        }
    }
}
