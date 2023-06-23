//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alvin Wo on 2023/6/12.
//

import SwiftUI

struct FlagImage: View {
    var country: String

    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle.weight(.heavy))
            .foregroundColor(.white)
    }
}

extension View {
    func largeWhiteTitle() -> some View {
        modifier(TitleModifier())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var currentScore = 0
    @State private var spin = 0.0
    @State private var tappedIndex = 0
    @State private var degrees = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var scales = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Guess The Flag")
                    .largeWhiteTitle()

                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer]).foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0 ..< 3) { number in
                    Button {
                        tappedIndex = number
                        flagTapped(number)
                        withAnimation {
                            tappedIndex = number
                            degrees[tappedIndex] += 360
                            for loopIndex in 0 ..< 3 {
                                if loopIndex != number {
                                    opacities[loopIndex] -= 0.25
                                    scales[loopIndex] -= 0.5
                                }
                            }
                        }
                    } label: {
                        FlagImage(country: countries[number])
                            .rotation3DEffect(
                                .degrees(degrees[number]), axis: (0, 1, 0)
                            )
                    }.opacity(opacities[number])
                        .scaleEffect(scales[number])
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Your answer is \(scoreTitle)"),
                  message: Text("score is \(currentScore)"),
                  primaryButton: .default(Text("Continue")) {
                      askQuestion()
                      for loopIndex in 0 ..< 3 {
                          opacities[loopIndex] = 1.0
                          scales[loopIndex] = 1.0
                      }
                  },
                  secondaryButton: .cancel())
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            currentScore += 1
            scoreTitle = "Correct"
        } else {
            currentScore -= 1
            scoreTitle = "Wrong"
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
