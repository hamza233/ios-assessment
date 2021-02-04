//
//  ViewController.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/2/21.
//

import UIKit

class EventListViewController: UITableViewController {
    var networkManager = NetworkManager()
    let itemArray = ["hello", "hola", "oye"]
    var eventList = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.fetchData { events in
            self.eventList = events
            self.tableView.reloadData()

        }
        
     

    }

    //MARK:- TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eventList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath ) as! EventCell
        let event = self.eventList[indexPath.row]
        
        
        cell.title.text = event.performers?[0].name
        cell.location.text = event.venue.display_location
        cell.time.text = event.datetime_utc
        cell.img.image = UIImage.init(named: "GOT")
        return cell
    }

}

