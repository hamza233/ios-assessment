//
//  DetailView.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/4/21.
//

import UIKit
import WebKit

class DetailView: UIViewController {
    // the variable ev will be sent from the EventListViewController, it will hold the event the user clicked on
    var ev: Event!
    
    // list of favorite events to add/remove this event in the list when user taps on tha heart
    var favList = [Int]()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the label to show the name of event, it will be displayed as title of the navigation item
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        label.backgroundColor = .clear
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ev.performers?[0].name ?? "No name"
        self.navigationItem.titleView = label
        // this variable will store the name of heart, it could be filled or empty
        var imageName: String = "suit.heart"
        // load the favorite events if the "favs" key exists
        if let list = defaults.object(forKey: "favs") as? [Int]{
            favList = list
            if (favList.contains(ev.id)){
                // set the image name to filled, if this event is in the fav list
                imageName = "suit.heart.fill"
            }
        
        // set the key "favs" if it doesn't exist... handles the case when the app is used for the first time and there is no fav event
        }else {
            defaults.set(favList, forKey: "favs")
        }
        // put the heart icon as the rightBarButton of navigatiomItem. favTapped function is triggered when this icon is tapped
        let favImage = UIImage(systemName: imageName)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let favButton = UIBarButtonItem(image: favImage, landscapeImagePhone: favImage, style: .plain, target: self, action: #selector(favTapped))
        self.navigationItem.rightBarButtonItem = favButton
        // update the date, time, location labels and the webview to load the image
        let date = String(ev.datetime_utc.prefix(10))
        let time = String(ev.datetime_utc.suffix(8).prefix(5))
        timeLabel.text = Utils.convertDate(stringDate: date) + " " + Utils.convertTime(stringTime: time)
        locationLabel.text = ev.venue.display_location
        if let safeUrl = ev.performers?[0].image{
            
            if let url = URL(string: safeUrl){
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    
  //MARK:- FavTapped() controls the interaction with heart icon
    @objc func favTapped(){
        // when the event is already fav, remove it from the list and change the icon from filled to empty
        if(favList.contains(ev.id)){    //get the index of event id and remove from favlist
            guard let index = favList.firstIndex(of: ev.id) else {
                return
            }
            favList.remove(at: index)
            print("\(ev.id) removed")
            // update the list in defaults
            defaults.set(favList, forKey: "favs")
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "suit.heart")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            
            
        // add the event in fav list when heart icon is tapped
        }else{
            favList.append(ev.id)
            defaults.set(favList, forKey: "favs")
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "suit.heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
        
        
    }
    
    
}
