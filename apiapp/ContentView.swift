import SwiftUI

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

struct ContentView: View {
    var body: some View {
        TabView {
            ProductsView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            HomePage()
                .tabItem {
                    Label("TobeCart", systemImage: "person.crop.circle.fill")
                }
            
            LoginPage()
                .tabItem {
                    Label("Login", systemImage: "person.crop.circle.fill")
                }
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
