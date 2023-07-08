//
//  ContentView.swift
//  MoonShot
//
//  Created by Alvin Wo on 2023/7/3.
//

import SwiftUI

struct ContentView: View {
    private let missions: [Mission] = Bundle.main.decode(fileName: "missions.json")
    private let astronauts: [String: Astronaut] = Bundle.main.decode(fileName: "astronauts.json")
    private let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Rectangle().frame(height: 2).foregroundColor(.lightBackground)
                        .padding(.vertical)

                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    VStack {
                                        Text(mission.displayName).font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.launchDateString).font(.caption)
                                            .foregroundColor(.white).opacity(0.8)
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
                    .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
