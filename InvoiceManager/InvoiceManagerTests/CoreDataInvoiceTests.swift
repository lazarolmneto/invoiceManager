//
//  CoreDataInvoiceTests.swift
//  InvoiceManagerTests
//
//  Created by Lazaro Neto on 13/06/22.
//

import XCTest
import CoreData
@testable import InvoiceManager

class CoreDataInvoiceTests: XCTestCase {

    private struct Constants {
        static let name = "Name Test"
        static let client = "Name Test"
        static let dateFormatt = "dd/MM/yyyy"
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let invoiceEntity = InvoiceEntity(context: moc)
        invoiceEntity.name = Constants.name
        invoiceEntity.client = Constants.name
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatt
        invoiceEntity.date = formatter.string(from: Date())
        
        moc.insert(invoiceEntity)
        
        guard let _ = try? moc.save() else {
            return assertionFailure("Did not save")
        }
        
        let predicate = NSPredicate(format: "name == %@ AND client == %@",
                                    argumentArray:[Constants.name, Constants.client])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InvoiceEntity")
        request.predicate = predicate
        
        guard let result = try? moc.fetch(request) else {
            return assertionFailure("Did not fetch")
        }
        
        print(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
