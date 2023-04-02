//
//  rename.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 31/03/2023.
//


import Foundation
import SwiftUI

struct CartView: View {
    
    //Jeg vet ikke hvorfor dette var nødvendig men den klagde når jeg ikke hadde alt dette her
    @State private var cart = Cart(id: nil, products: [], total: nil, discountedTotal: nil, userId: nil, totalProducts: nil, totalQuantity: nil)
    
    var body: some View {
        //Navigationviewen gjør at jeg kan ha en navigationtitle slik at det ser litt bedre ut
        NavigationView {
            VStack {
                //Sjekker om discounted total har en verdi, hvis ikke vises 0
                //UnsafelyUnwrapped henter ut int verdien til en int? uten å sjekke om den har verdi
                //Men det går bra fordi det blir sjekket rett før
                Text("Cart Total price: \(cart.discountedTotal != nil ? cart.discountedTotal.unsafelyUnwrapped : 0)")
                    .font(.subheadline)
                
                //Viser all produktene i handlevognen.s
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
        .onAppear {
            let url = URL(string: "https://dummyjson.com/carts/1")!
            let request = URLRequest(url: url)
            
            //Henter data fra apiet og lagrer det i state variabelen cart.
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Cart.self, from: data) {
                        DispatchQueue.main.async {
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

//Disse to definerer strukturen på datene man får i retur fra apiet.
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
