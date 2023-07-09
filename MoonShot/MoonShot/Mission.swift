//
//  Mission.swift
//  MoonShot
//
//  Created by Alvin Wo on 2023/7/5.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let crew: [Crew]
    let launchDate: Date?
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var launchDateString: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "NA"
    }
}
