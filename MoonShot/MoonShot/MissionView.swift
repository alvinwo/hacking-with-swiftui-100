//
//  MissionView.swift
//  MoonShot
//
//  Created by Alvin Wo on 2023/7/8.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    Text(mission.launchDate?.formatted(date: .complete, time: .standard) ?? "N/A")

                    VStack(alignment: .leading) {
                        MyDividerView()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)

                    AstronautScrollView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode(fileName: "missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode(fileName: "astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
