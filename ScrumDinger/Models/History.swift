//
//  History.swift
//  ScrumDinger
//
//  Created by Furkan Can Baytemur on 30.06.2022.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lenghtMinutes: Int
    var transcript: String?

    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], lenghtMinutes: Int = 5, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lenghtMinutes = lenghtMinutes
        self.transcript = transcript
    }
}
