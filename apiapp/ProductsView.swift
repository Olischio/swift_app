//
//  ProductsView.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 30/03/2023.
//

import SwiftUI

struct ProductsView: View {
    //lages tom og fylles med data fra api kall
    @State var products: [Product] = []
    @State var selectedProduct: Product?
    
    var body: some View {
        //NavigationView(en) er brukt til at Navigationlinken skal kunne sende deg til ProductView, den gjør også at navigationtitle kan vises
        NavigationView {
            List(products, id: \.id) { product in
                HStack {
                    VStack(alignment: .leading) {
                        
                        AsyncImage(url: product.thumbnail) {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }

                        Text(product.title ?? "")
                            .font(.headline)
                        Text("$\(product.price ?? 1, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                    NavigationLink(destination: ProductView(product: product), tag: product, selection: $selectedProduct) {
                    }
                }
                
                .navigationTitle("Products")
            }
        }
        .onAppear {
            // Henter de 100 produktene som er i denne produktdatabasen.
            let url = URL(string: "https://dummyjson.com/products?limit=100&skip=0")!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(ProductMeta.self, from: data) {
                        DispatchQueue.main.async {
                            self.products = decodedResponse.products
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
            print(products)
            
        }
    }
}

// Disse to structene definerer strukturen på dataene som kommer fra apiet.
struct ProductMeta: Codable {
    var products: [Product]
}

struct Product: Codable, Hashable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var thumbnail: URL?
}
