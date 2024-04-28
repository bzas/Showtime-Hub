//
//  KeychainManager.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import Foundation

class LocalStorage {
    let serviceIdentifier = "com.Boizas.MovieRadar.apiKey"

    func saveApiKey(apiKey: String) -> Bool {
        guard let keyData = apiKey.data(using: .utf8) else {
            return false
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecValueData as String: keyData
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        return status == errSecSuccess
    }

    func retrieveApiKey() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                return String(data: retrievedData, encoding: .utf8)
            }
        }

        return nil
    }
}
