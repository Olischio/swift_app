//
//  rename.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 31/03/2023.
//


import Foundation
import SwiftUI

struct CartView: View {
    
    @State private var cart = Cart(id: nil, products: [], total: nil, discountedTotal: nil, userId: nil, totalProducts: nil, totalQuantity: nil)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Cart Total price: \(cart.discountedTotal != nil ? cart.discountedTotal.unsafelyUnwrapped : 0)")
                    .font(.subheadline)
                
                List(cart.products, id: \.id) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                                .font(.subheadline)
                            Text("Price $\(product.discountedPrice, specifier: "%.2f")")
                                .font(.subheadline)
                            Text("Quantity: \(product.quantity)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Cart")
        }
        
        
     // List(cart.products) { item in
       //   Text(item.title ?? "")
        //}
        .onAppear {
            let url = URL(string: "https://dummyjson.com/carts/1")!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Cart.self, from: data) {
                        DispatchQueue.main.async {
                            print("HER")
                            self.cart = decodedResponse
                        }
                        return
                    }
                    else{
                        print("decode failed")
                    }
                }else{
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
                
                
            }.resume()
        }
    }
}

struct Cart: Codable {
    let id: Int?
    let products: [CartProduct]
    let total: Int?
    let discountedTotal: Int?
    let userId: Int?
    let totalProducts: Int?
    let totalQuantity: Int?
}

struct CartProduct: Codable, Hashable {
    let id: Int
    let title: String
    let price: Int
    let quantity: Int
    let total: Int
    let discountPercentage: Double
    let discountedPrice: Double
}
