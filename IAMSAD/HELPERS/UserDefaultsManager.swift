//
//  UserDefaultsManager.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import Foundation

enum UserDefaultsNAppStorageKeys: String, CaseIterable {
    // NOTE: For any reason, don't change these case names in production, as it may erase what the app has saved to user defaults or app storage.
    
    // APP
    case sample
    
    // Account & Settings
    
}

actor UserDefaultsManager {
    private let defaults: UserDefaults = .standard
    
    // MARK: - removeValue
    private func removeValue(key: UserDefaultsNAppStorageKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    // MARK: - saveValue
    func saveValue(value: Any?, key: UserDefaultsNAppStorageKeys) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    // MARK: - getValueAny
    func getValueAny(key: UserDefaultsNAppStorageKeys) -> Any? {
        defaults.value(forKey: key.rawValue)
    }
    
    // MARK: - getValueBool
    func getValueBool(key: UserDefaultsNAppStorageKeys) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }
    
    // MARK: - getValueInt
    func getValueInt(key: UserDefaultsNAppStorageKeys) -> Int {
        defaults.integer(forKey: key.rawValue)
    }
    
    // MARK: - getValueDouble
    func getValueDouble(key: UserDefaultsNAppStorageKeys) -> Double {
        defaults.double(forKey: key.rawValue)
    }
    
    // MARK: - getValueString
    func getValueString(key: UserDefaultsNAppStorageKeys) -> String? {
        defaults.string(forKey: key.rawValue)
    }
    
    // MARK: - getValueData
    func getValueData(key: UserDefaultsNAppStorageKeys) -> Data? {
        defaults.data(forKey: key.rawValue)
    }
    
    // MARK: - getValueArrayAny
    func getValueArrayAny(key: UserDefaultsNAppStorageKeys) -> [Any]? {
        defaults.array(forKey: key.rawValue)
    }
    
    // MARK: - getValueDictionary
    func getValueDictionary(key: UserDefaultsNAppStorageKeys) -> [String: Any]? {
        defaults.dictionary(forKey: key.rawValue)
    }
    
    // MARK: - getValueURL
    func getValueURL(key: UserDefaultsNAppStorageKeys) -> URL? {
        defaults.url(forKey: key.rawValue)
    }
    
    // MARK: - clearUserDefaultsOnQuickBugFix
    func clearUserDefaultsOnQuickBugFix() {
        //        let filteredKeysArray: Set<UserDefaultsNAppStorageKeys> = Set([
        //            .appDemo_Bool,
        //            .sceneManagerFirstInitializer_Bool,
        //            .scenesArray_SceneModel_Data,
        //            .threeDaysFreeTrial_Date
        //        ])
        //        
        //        for key in UserDefaultsNAppStorageKeys.allCases where !filteredKeysArray.contains(key) {
        //            removeValue(key: key)
        //            print("\(key.rawValue) Has Been Removed From User Defaults Successfully. 👍🏻👍🏻👍🏻")
        //        }
    }
    
#if DEBUG
    // MARK: - clearAllUserDefaults
    // Use this only if needed
    func clearAllUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
#endif
}
