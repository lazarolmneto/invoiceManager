//
//  InvoiceDetailLogicController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

class InvoiceDetailLogicController {
    
    let invoice: InvoiceEntity
    private let context: NSManagedObjectContext
    
    init(invoice: InvoiceEntity,
         context: NSManagedObjectContext) {
        
        self.invoice = invoice
        self.context = context
    }
    
    func saveInvoice(name: String,
                     client: String,
                     date: String) {
        
        self.invoice.name = name
        self.invoice.client = client
        self.invoice.date = date
        
        do {
            try context.save()
            
            NotificationCenter.default.post(name: NotificationKeys.fetchNewItems.notificationName,
                                            object: nil)
        } catch {
            print("Error")
        }
    }
    
    func deleteInvoice() {
        
        do {
            context.delete(invoice)
            try context.save()
            
            NotificationCenter.default.post(name: NotificationKeys.fetchNewItems.notificationName,
                                            object: nil)
        } catch {
            print("Error")
        }
    }
}
