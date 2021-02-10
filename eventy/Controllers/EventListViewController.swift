//
//  ViewController.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/2/21.
//

import UIKit

@available(iOS 13.0, *)
class EventListViewController: UITableViewController {
    var networkManager = NetworkManager()
    var eventList = [Event]()                   // will hold all events
    var searchedList = [Event]()                // will hold searched events
    var isSearching = false                     // true when user types in the searchbar
    var favourits = [Int]()                     // holds ids of favorite events
    let defaults = UserDefaults.standard        // user defaults will save the favorite events
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // viewWillAppear is used instead of viewDidLoad because viewDidLoad doesn't get triggered when user clicks back button on //the DetailView
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.titleView = searchBar      // put the search bar in navigationbar
        
        //network call
        networkManager.fetchData { events in
            // save the fetched data
            self.eventList = events
            
            // retrieve the favorite events from user defaults and reload the tableview
            if let list = self.defaults.object(forKey: "favs") as? [Int]{
                self.favourits = list
                self.tableView.reloadData()
            }
    
        }
    }
    
    
    
    //MARK:- TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return the event count based on search status
        if isSearching{
            return searchedList.count
        }else{
            return eventList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the cell as EventCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath ) as! EventCell
        
        // this variable will store a specific event to populate the cells
        var event: Event
        // set the event variable based on search status
        if isSearching{
             event = self.searchedList[indexPath.row]
        }else{
             event = self.eventList[indexPath.row]
        }
        
        //update the cell
        
        // show/hide the heart image
        if !favourits.contains(event.id){
            cell.favImg.isHidden = true
        }else{
            cell.favImg.isHidden = false
        }
        // the date format is yyyy-mm-ddTHH:MM:SS
        // first 10 chars represent the date
        let date = String(event.datetime_utc.prefix(10))
        // last 8 chars represent the time, then take the first five of them to consider only hours and minutes
        // take only HH:MM from HH:MM:SS
        let time = String(event.datetime_utc.suffix(8).prefix(5))
        // update the title, location, time and date labels of cell
        cell.title.text = event.performers?[0].name
        cell.location.text = event.venue.display_location
        cell.time.text =  Utils.convertTime(stringTime: time)
        cell.date.text = Utils.convertDate(stringDate: date)
        
        // load the image from the link in webview
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
        
        // set the vc based on search status
        if (isSearching){
            vc?.ev = self.searchedList[indexPath.row]
        }else{
            vc?.ev = self.eventList[indexPath.row]
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

//MARK:- Search Bar methods

@available(iOS 13.0, *)
extension EventListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // filter the events as user enters text in the search bar
        searchedList = eventList.filter({ ($0.performers?[0].name?.contains(searchText))!
        })
        isSearching = true
        tableView.reloadData()
    }
    
    // reset search status to load the events normally
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}


