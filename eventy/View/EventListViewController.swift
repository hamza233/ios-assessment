//
//  ViewController.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/2/21.
//

import UIKit

class EventListViewController: UITableViewController {
    var networkManager = NetworkManager()
    var eventList = [Event]()
    var cellID: Int = 0
    var cellName: String = ""
    var cellLocation: String = ""
    var cellTime: String = ""
    var imgURL: String = ""
    var selectedEvent: Event!
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
            
            //update the cell
            cell.title.text = event.performers?[0].name
            cell.location.text = event.venue.display_location
            cell.time.text = event.datetime_utc
            if let safeUrl = event.performers?[0].image{
                       if let url = URL(string: safeUrl){
                           let request = URLRequest(url: url)
                           cell.webView.load(request)
                       }
                   }
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailView
        vc?.ev = self.eventList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    // MARK: - Navigation

//      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//          if segue.destination is DetailView{
//            let vc = segue.destination as? DetailView
//            vc?.ev = self.selectedEvent
//          }
//        
//    
//      }

}


