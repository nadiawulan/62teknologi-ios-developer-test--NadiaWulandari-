//
//  PredictAgeView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

class UniversityListViewModel: ObservableObject {
    @Published var universities = [University]()
    
    func fetchUniversities() {
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=Indonesia") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let universities = try JSONDecoder().decode([University].self, from: data)
                    DispatchQueue.main.async {
                        self.universities = universities
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct UniversityListView: View {
    @ObservedObject private var universityListViewModel = UniversityListViewModel()
    
    var body: some View {
        List(universityListViewModel.universities) { university in
            VStack(alignment: .leading) {
                Text(university.name)
                    .font(.headline)
                Text(university.country)
                    .font(.subheadline)
            }
        }
        .onAppear {
            universityListViewModel.fetchUniversities()
        }
        .navigationBarTitle("Universitas")
    }
}
