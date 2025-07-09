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
    static let encryptionKeyKey = "vault_encryption_key"

    static func saveEncryptionKey(_ key: SymmetricKey) {
        let tag = Data(encryptionKeyKey.utf8)
        let keyData = key.withUnsafeBytes { Data($0) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecValueData as String: keyData
        ]

        // Clean up before adding
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        if status != errSecSuccess {
            print("🔐 Keychain save error: \(status)")
        }
    }

    static func loadEncryptionKey() -> SymmetricKey? {
        let tag = Data(encryptionKeyKey.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status != errSecSuccess {
            print("🔐 Keychain load error: \(status)")
            return nil
        }

        guard let data = result as? Data else {
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
