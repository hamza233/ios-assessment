//
//  NetworkManager.swift
//  event finder
//
//  Created by Hamza Mahmood on 1/30/21.
//

import Foundation

class NetworkManager{
    // eventList will store all the fetched events
    var eventList = [Event]()
    func fetchData(completionHandler: @escaping ([Event]) -> Void){
        var events = [Event]()
        if let url = Foundation.URL(string: "https://api.seatgeek.com/events?client_id=MjE1MjE4NDB8MTYxMTk5NjE0My42MjcwMjEz"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(Results.self, from: safeData)
                            // do this task asynchronously
                            DispatchQueue.main.async {
                                self.eventList = result.events
                                events = result.events
                                completionHandler(events)
                            }
                        }
                    catch{
                            print(error)
                       }
                    }
                }
            }
            task.resume()
        }
       
    }
    
}
