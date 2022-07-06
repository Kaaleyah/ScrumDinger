//
//  DailyScrum.swift
//  ScrumDinger
//
//  Created by Furkan Can Baytemur on 24.06.2022.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthMinutes = lengthMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthMinutes: Double(lengthMinutes), theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthMinutes = Int(data.lengthMinutes)
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        lengthMinutes = Int(data.lengthMinutes)
        theme = data.theme
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Sam", "Kevin", "Saul", "Ignacio", "Gus"], lengthMinutes: 4, theme: .poppy),
        DailyScrum(title: "Mobile Dev", attendees: ["Dexter", "Reagen", "Mikael", "Ben"], lengthMinutes: 7, theme: .buttercup),
        DailyScrum(title: "Marketing", attendees: ["Mason", "Paige", "Miranda", "Blake", "Lex", "Margot", "Albert", "Kian", "Andrew", "Adam"], lengthMinutes: 5, theme: .lavender)
    ]
}
