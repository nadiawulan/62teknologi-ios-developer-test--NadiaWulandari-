//
//  CatFactView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI
 
struct CatFact: Codable {
    let fact: String
}
 
class CatFactViewModel: ObservableObject {
    @Published var catFact: String = ""
    private let apiUrl = URL(string: "https://catfact.ninja/fact")!
 
    func fetchCatFact() {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { return }
 
            do {
                let decodedData = try JSONDecoder().decode(CatFact.self, from: data)
                DispatchQueue.main.async {
                    self.catFact = decodedData.fact
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
 
struct CatFactView: View {
    @ObservedObject private var catFactViewModel = CatFactViewModel()
 
    var body: some View {
        VStack {
            Text("Get Random Cat Fact")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
 
            Button(action: {
                self.catFactViewModel.fetchCatFact()
            }) {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
 
            Text(catFactViewModel.catFact)
                .padding()
 
            Spacer()
        }
    }
}
