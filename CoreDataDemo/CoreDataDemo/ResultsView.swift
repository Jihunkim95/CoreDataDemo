//
//  ResultsView.swift
//  CoreDataDemo
//
//  Created by 김지훈 on 2023/12/27.
//

import SwiftUI
import CoreData
// 검색기능
struct ResultsView: View {
    var name: String
    var viewContext: NSManagedObjectContext
    
    @State var matches: [Product]?
    var body: some View {
        
        return VStack{
            List{
                ForEach(matches ?? []){ matche in
                    HStack{
                        Text(matche.name ?? "Not found")
                        Spacer()
                        Text(matche.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Results")
        }
        // 검색 실행전 모든 속성 초기화
        .task {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.entity = Product.entity()
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
            matches = try? viewContext.fetch(fetchRequest)
        }
    }
    
}


