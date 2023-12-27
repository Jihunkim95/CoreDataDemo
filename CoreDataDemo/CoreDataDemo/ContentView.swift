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
    //FetchRequest는 코어데이터가 데이터 베이스에 저장된 최신 제품 데이터를 저장할 products라는 변수를 선언하는데 사용
    // name오름 차순정렬
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationStack{
            VStack{
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack{
                    Spacer()
                    Button("Add"){
                        addProduct()
                    }
                    Spacer()
                    NavigationLink(destination: ResultsView(name: name, viewContext: viewContext)){
                        Text("Find")
                    }
                    Spacer()
                    Button("Clear"){
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                
                List{
                    ForEach(products) { product in
                        HStack{
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not fount")
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .frame(maxWidth: .infinity)
            

        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
    //Button이 addProduct를 호출하면 보여주고 저장
    private func addProduct(){
        withAnimation{
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            
            saveContext()
        }
    }
    // 삭제
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    // 영구 저장소에 저장
    private func saveContext(){
        do{
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occurred: \(error)")
        }
    }
}


