//
//  Bundle-load.swift
//  MoonShot
//
//  Created by Alvin Wo on 2023/7/5.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(fileName: String) -> T {
        guard let url = url(forResource: fileName, withExtension: nil) else {
            fatalError()
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }

        return loaded
    }
}
