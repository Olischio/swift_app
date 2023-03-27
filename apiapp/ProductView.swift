//
//  ProductView.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 27/03/2023.
//

import Foundation
import SwiftUI

struct ProductView: View {
    var product: Product
    var body: some View {
        
        Text(product.title ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
        
        Text(product.description ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
        
        Text(product.category ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
    }
}
