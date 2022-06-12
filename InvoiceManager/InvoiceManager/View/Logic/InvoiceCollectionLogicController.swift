//
//  InvoiceCollectionLogicController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 12/06/22.
//

import UIKit
import CoreData

protocol InvoiceCollectionLogicControllerDelegate {
    
    func didFetchData()
}

class InvoiceCollectionLogicController: NSObject {

    private (set) var invoices: [InvoiceEntity] = []
    let context: NSManagedObjectContext
    
    //delegate
    private var delegate: InvoiceCollectionLogicControllerDelegate?
    
    init(context: NSManagedObjectContext) {
        
        self.context = context
        super.init()
        self.addNotificationTarget()
    }

    func loadInvoices() {
        
        self.invoices.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InvoiceEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let entities = result.map { mapResult in
                return mapResult as! InvoiceEntity
            }
            self.invoices.append(contentsOf: entities)

            self.delegate?.didFetchData()
       } catch {
           print("Failed")
       }
    }
    
    func setDelegate(delegate: InvoiceCollectionLogicControllerDelegate) {
        self.delegate = delegate
    }
    
    func addNotificationTarget() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didNotifyToFetchInvoices),
                                               name: NotificationKeys.fetchNewItems.notificationName,
                                               object: nil)
    }
    
    @objc fileprivate func didNotifyToFetchInvoices() {
        self.loadInvoices()
    }
}
