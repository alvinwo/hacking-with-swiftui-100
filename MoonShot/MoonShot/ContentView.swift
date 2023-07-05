//
//  ContentView.swift
//  MoonShot
//
//  Created by Alvin Wo on 2023/7/3.
//

import SwiftUI

struct ContentView: View {
    private let missions: [Mission] = Bundle.main.decode(fileName: "missions.json")
    private let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            VStack {
                                Text("Details").font(.largeTitle)
                                Text(mission.description)
                            }
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName).font(.headline)
                                    Text(mission.launchDateString).font(.caption)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("MoonShot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
