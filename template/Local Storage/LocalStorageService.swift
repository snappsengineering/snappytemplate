//
//  LocalStorageService.swift
//
//  Created by snapps
//

import Foundation

protocol Storable: Equatable, Codable {}

struct LocalStorageService<T> {
    static func fetch<T: Storable>(element: T) -> T {
        guard let filePath = getFilePath(for: element) else { return element }
        let jsonDecoder = JSONDecoder()
        do {
            if let jsonData = try? Data(contentsOf: filePath) {
                return try jsonDecoder.decode(T.self, from: jsonData)
            }
        } catch {
            remove(filePath: filePath.path)
        }
        return element
    }

    static func store<T: Storable>(element: T) {
        guard let filePath = getFilePath(for: element) else { return }
        remove(filePath: filePath.path)
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(element)
            try jsonData.write(to: filePath)
        } catch {
        // handle error
        }
    }
    
    private static func remove(filePath: String) {
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    private static func getFilePath<T: Storable>(for element: T) -> URL? {
        let filePath = getPath(from: element.self)
        guard let libraryPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else { return nil }
        return libraryPath.appendingPathComponent(filePath)
    }
    
    private static func getPath<T: Storable>(from type: T) -> String {
        return "\(type.self).json"
    }
}
