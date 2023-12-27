//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by 김지훈 on 2023/12/27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // 제품 이름과 수량을 저장
    @State var name: String = ""
    @State var quantity: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Product.entity(), sortDescriptors: [])
    private var items: FetchedResults<Item>

    var body: some View {
        Text("Hello World!")
    }
}


