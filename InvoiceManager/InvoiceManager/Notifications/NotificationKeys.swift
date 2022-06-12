//
//  NotificationKeys.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 12/06/22.
//

import UIKit

enum NotificationKeys: String {

    case fetchNewItems = "fetch_new_items"
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
