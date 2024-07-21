//
//  EncryptModel.swift
//  Swift message encrypter
//
//  Created by Noah Moller on 21/7/2024.
//

import Foundation
import CryptoKit

class EncryptModel: ObservableObject {
    @Published var DecryptedData = Data()
    
    // Function to generate a symmetric key
    func generateSymmetricKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    // Function to encrypt data
    func encrypt(data: Data, using key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
    // Function to decrypt data
    func decrypt(data: Data, using key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    // Usage example
    func example(data: String) {
        do {
            // Generate a key
            let key = generateSymmetricKey()
            
            // Original data
            let originalData = data.data(using: .utf8)!
            
            // Encrypt the data
            let encryptedData = try encrypt(data: originalData, using: key)
            print("Encrypted Data: \(encryptedData.base64EncodedString())")
            
            // Decrypt the data
            let decryptedData = try decrypt(data: encryptedData, using: key)
            let decryptedString = String(data: DecryptedData, encoding: .utf8)!
            print("Decrypted Data: \(decryptedString)")
        } catch {
            print("Error: \(error)")
        }
    }
}
