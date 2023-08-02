//
//  URLImage.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    let url: String
    
    @State private var imageData: Data?
    
    var body: some View {
        getImageFromURL()
    }
    
    private func getImageFromURL() -> some View {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            return Image(systemName: "questionmark.square")
                .resizable()
                .scaledToFit()
        }
    }
    
    private func loadImageFromURL() {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}
