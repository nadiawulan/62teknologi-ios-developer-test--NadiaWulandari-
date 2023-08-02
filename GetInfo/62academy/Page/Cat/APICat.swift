//
//  APICat.swift
//  62academy
//
//  Created by NadiaWulandari on 30/07/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import Combine
 
class CatFactAPICat: ObservableObject {
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
