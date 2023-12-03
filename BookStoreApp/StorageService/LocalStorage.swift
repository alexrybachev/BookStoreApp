//
//  LocalStorage.swift
//  BookStoreApp
//
//  Created by Alex on 03.12.2023.
//

import Foundation

enum StorageKeys: String {
    case liked
}

final class LocalStorageService {

    private init() {}
    static let shared = LocalStorageService()

    func saveLike(object: LikeModel, key: StorageKeys.RawValue) {
        save(object, key: key)
    }

    func loadLike(objectKey: StorageKeys.RawValue) -> LikeModel? {
        load(key: objectKey)
    }

    func clearLike(objectKey: StorageKeys) {
        UserDefaults.standard.removeObject(forKey: objectKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    private func save<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("\(T.Type.self) saving failed")
        }
    }

    private func load<T: Codable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }

        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print("\(T.Type.self) loading failed")
            return nil
        }
    }
}

