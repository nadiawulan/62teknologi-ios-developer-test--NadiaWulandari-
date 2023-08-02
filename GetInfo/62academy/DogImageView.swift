//
//  DogImageView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct DogImage: Codable {
    let message: String
}

class DogImageViewModel: ObservableObject {
    @Published var dogImageUrl: String = ""
    
    func fetchDogImage() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(DogImage.self, from: data)
                    DispatchQueue.main.async {
                        self.dogImageUrl = decodedData.message
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct DogImageView: View {
    @ObservedObject private var dogImageViewModel = DogImageViewModel()
    
    var body: some View {
        VStack {
            Text("Random Dog Image")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                self.dogImageViewModel.fetchDogImage()
            }) {
                Text("Get Random Dog Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            URLImage(url: dogImageViewModel.dogImageUrl)
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Spacer()
        }
        .padding()
        .onReceive(dogImageViewModel.$dogImageUrl) { _ in
        }
    }
}

struct DogImageView_Previews: PreviewProvider {
    static var previews: some View {
        DogImageView()
    }
}
