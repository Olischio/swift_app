

import SwiftUI

struct ProductMeta: Codable {
    var products: [Product]
}

struct Product: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
}

struct ContentView: View {
    @State var products: [Product] = []

    var body: some View {
        List(products, id: \.id) { product in
            
            //NavigationLink(destination: ItemView, label: View){
                //hele HStack skal inn her
            //}
            
            
            
            HStack {
                Image(systemName: "photo")
                    //.data(url: URL(string: product.image ?? "")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(product.title ?? "")
                        .font(.headline)
                    Text("$\(product.price ?? 1, specifier: "%.2f")")
                        .font(.subheadline)
                }
                
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
        }
        return self
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
