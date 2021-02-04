//
//  eventData.swift
//  event finder
//
//  Created by Hamza Mahmood on 1/30/21.
//

import Foundation

struct Results: Decodable {
    var events = [Event]()
}

struct Event: Decodable, Identifiable {
    let id: Int
    let datetime_utc: String
    let performers: [Performer]?
    let venue: Venue
}

struct Performer: Decodable {
    let name: String?
    let image: String
}

struct Venue: Decodable {
    let display_location: String
}


