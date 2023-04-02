import SwiftUI

//Hele denne koden er det som lager navigeringsbaren i bunnen av appen som blir brukt for alle 3 hovedsidene i appen
struct ContentView: View {
    var body: some View {
        TabView {
            ProductsView()
                .tabItem {
                    Label("Products", systemImage: "briefcase")
                }
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            
            LoginPage()
                .tabItem {
                    Label("Login", systemImage: "person.crop.circle.fill")
                }
        }
    }
}
