//
//  KeychainManager.swift
//  YHT
//
//  Created by 이건준 on 2/18/24.
//

import Foundation

class KeychainManager {
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    static func addItemsOnKeyChain(token: String, key: String) {
        let tokenData = token.data(using: String.Encoding.utf8)!  // pw를 암호화시킨 것
        
        // query (질의)를 통해 개발자는 keychain에게 질문을 함
        // "이걸 Keychain에 보관해줄래?"
        // "kSecClassGenericPassword (일반적인 비밀번호)라는 query인데, 암호화해서 보관할 데이터는 password야"
        let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: tokenData,
                kSecAttrService as String: "YHT"
            ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        // "query를 던질건데 pw는 신경쓰지 않겠다, nil 대신 item에 담아서 서버로 보내겠다"
        // 기밀정보가 많다면, data 중에서 뭘 필요로 할지 필터링할 수 있도록 한 것
        
        if status == errSecSuccess {
            //print("add success")
        } else if status == errSecDuplicateItem {
            //print("keychain에 Item이 이미 있음")
        } else {
            //print("add failed")
        }
    }
    
    static func searchItemFromKeychain(key: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else { return nil } // 해당 키에 대한 항목을 찾을 수 없는 경우 nil 반환
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        
        guard let passwordData = item as? Data,
              let password = String(data: passwordData, encoding: .utf8) else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    static func updateItemOnKeyChain(token: String, key: String) {
        let previousQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                            kSecAttrAccount as String: key]  // search query

        let newToken = token.data(using: .utf8)
        let updateQuery: [String: Any] = [kSecValueData as String: newToken!]  // 업데이트할 Item
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)

        if status == errSecSuccess {
            //print("update complete")
        } else {
            //print("not finished update")
        }
    }
    
    static func deleteItemFromKeychain(key: String) {
        // 삭제할 아이템에 대한 쿼리 생성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        // Keychain에서 아이템 삭제
        let status = SecItemDelete(query as CFDictionary)
        
        // 삭제 결과에 따른 처리
        if status == errSecSuccess {
            //print("Item deleted successfully from Keychain")
        } else if status == errSecItemNotFound {
            //print("Item not found in Keychain")
        } else {
            //print("Error deleting item from Keychain")
        }
    }

}
