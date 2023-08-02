//
//  JokeView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI
 
struct Joke: Codable {
    let setup: String
    let punchline: String
}
 
class JokeViewModel: ObservableObject {
    @Published var jokeSetup: String = ""
    @Published var jokePunchline: String = ""
    private let apiUrl = URL(string: "https://official-joke-api.appspot.com/random_joke")!
 
    func fetchJoke() {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { return }
 
            do {
                let decodedData = try JSONDecoder().decode(Joke.self, from: data)
                DispatchQueue.main.async {
                    self.jokeSetup = decodedData.setup
                    self.jokePunchline = decodedData.punchline
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
 
struct JokeView: View {
    @ObservedObject private var jokeViewModel = JokeViewModel()
 
    var body: some View {
        VStack {
            Text("Get Random Joke")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
 
            Button(action: {
                self.jokeViewModel.fetchJoke()
            }) {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
 
            Text(jokeViewModel.jokeSetup)
                .padding()
 
            Text(jokeViewModel.jokePunchline)
                .padding()
 
            Spacer()
        }
    }
}
