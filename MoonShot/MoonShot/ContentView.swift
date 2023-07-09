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
    @State private var showGridView = false

    var listView: some View {
        List {
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
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }

    var gridView: some View {
        ScrollView {
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
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if showGridView {
                    VStack {
                        gridView
                            .padding(.bottom)
                    }
                } else {
                    listView.padding(.bottom)
                }
            }
            .padding(.horizontal)
            .navigationTitle("MoonShot")
            .navigationBarItems(trailing:
                Button {
                    showGridView.toggle()
                } label: {
                    Text("click")
                }
            )
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
