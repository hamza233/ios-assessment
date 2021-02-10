//
//  EventCellViewController.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/2/21.
//

import Foundation
import UIKit
import WebKit

// outlets of the custom cellcs
class EventCell: UITableViewCell {
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var webView: WKWebView!   // will display the image using link
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
}
