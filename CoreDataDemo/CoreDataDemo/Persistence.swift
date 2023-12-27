//
//  Persistence.swift
//  CoreDataDemo
//
//  Created by 김지훈 on 2023/12/27.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Products")
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
            
        }
    }
}
