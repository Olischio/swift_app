//
//  ProductsView.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 30/03/2023.
//

import SwiftUI

struct ProductsView: View {
    @State var products: [Product] = []
    @State var selectedProduct: Product?
    
    var body: some View {
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
            let url = URL(string: "https://dummyjson.com/products")!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(ProductMeta.self, from: data) {
                        DispatchQueue.main.async {
                            print("HER")
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

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
