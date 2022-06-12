//
//  InvoiceDetailLogicController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

class InvoiceDetailLogicController {
    
    let invoice: Invoice
    private let context: NSManagedObjectContext
    
    init(invoice: Invoice,
         context: NSManagedObjectContext) {
        
        self.invoice = invoice
        self.context = context
    }
    
    func saveInvoice() {
        
        let entity = InvoiceEntity(context: self.context)
        entity.id = invoice.id
        entity.name = "TESTE 1" //invoice.name
        entity.client = "teste 1" //invoice.client
        entity.date = "23/09/1994"//invoice.date
        entity.image = invoice.invoiceImage
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
}
