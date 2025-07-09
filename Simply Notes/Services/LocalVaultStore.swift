//
//  LocalVaultStore.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 09/07/25.
//

import Foundation
import CryptoKit

class LocalVaultStore {
    private let fileURL: URL
    private let encryptedKey: SymmetricKey
    
    init(filename: String = "vault_notes.json") {
        self.fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
        self.encryptedKey = KeychainHelper.generateAndStoreKeyIfNeeded()
    }
    
    func save(_ notes: [VaultNote]) {
        do {
            let jsonData = try JSONEncoder().encode(notes)
            let stringData = String(decoding: jsonData, as: UTF8.self)
            let encrypted = try AESCrypto.encrypt(stringData, encryptedKey)
            try encrypted.write(to: fileURL)
        } catch {
            print("Vault save error: \(error)")
        }
    }
    
    func load() -> [VaultNote] {
        do {
            let encypted = try Data(contentsOf: fileURL)
            let decrypted = try AESCrypto.decrypt(encypted, encryptedKey)
            let data = Data(decrypted.utf8)
            return try JSONDecoder().decode([VaultNote].self, from: data)
        } catch {
            print("Vault load error: \(error)")
            return []
        }
    }
}
