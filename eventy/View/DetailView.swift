//
//  DetailView.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/4/21.
//

import UIKit
import WebKit

class DetailView: UIViewController {

   
    
    var ev: Event!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ev.performers?[0].name ?? "No name"
        // Do any additional setup after loading the view.
        timeLabel.text = ev.datetime_utc
        locationLabel.text = ev.venue.display_location
        
        if let safeUrl = ev.performers?[0].image{
                
                    if let url = URL(string: safeUrl){
                        let request = URLRequest(url: url)
                        webView.load(request)
                    }
                }
    }
    

    
   
    

}
