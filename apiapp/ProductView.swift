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
        
        AsyncImage(url: product.thumbnail) {image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }

        
        Text(product.description ?? "")
            .font(.body)
          
        
        
            
    }
}
