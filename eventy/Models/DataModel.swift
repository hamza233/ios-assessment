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
// Event holds an event
struct Event: Decodable, Identifiable {
    let id: Int
    let datetime_utc: String
    let performers: [Performer]? // performers are nested in the event and needs a separate struct
    let venue: Venue  // Venue is also nested
}

struct Performer: Decodable {
    let name: String?
    let image: String    // link of image
}

struct Venue: Decodable {
    let display_location: String
}


