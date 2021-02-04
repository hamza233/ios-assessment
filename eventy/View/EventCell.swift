//
//  EventCellViewController.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/2/21.
//

import Foundation
import UIKit
import WebKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    
}
