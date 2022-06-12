//
//  Coodinator+InvoiceDetail.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

protocol CoordinatorInvoiceDetail {
    
    func goToInvoiceDetail(from vc: UIViewController,
                           invoice: Invoice,
                           coordinator: Coordinator?,
                           context: NSManagedObjectContext)
}

extension Coordinator: CoordinatorInvoiceDetail {
 
    func goToInvoiceDetail(from vc: UIViewController,
                           invoice: Invoice,
                           coordinator: Coordinator?,
                           context: NSManagedObjectContext) {
        
        let logicController = InvoiceDetailLogicController(invoice: invoice,
                                                           context: context)
        let viewTo = InvoiceDetailViewController(logicController: logicController,
                                                 coordinator: coordinator)
        self.present(from: vc, to: viewTo)
    }
}
