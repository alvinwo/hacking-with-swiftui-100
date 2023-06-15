//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alvin Wo on 2023/6/13.
//

import SwiftUI

struct ChoiceView: View {
    var choice: String
    @Binding var isPresented: Bool
    @Binding var shouldWin: Bool
    var action: () -> Void

    var body: some View {
        Button(choice, action: action)
            .font(.largeTitle.weight(.heavy))
            .alert(isPresented: $isPresented) {
                let message = "You " + (shouldWin ? "win!" : "loose!")
                return Alert(title: Text(message))
            }
    }
}

struct ContentView: View {
    let choices = ["👊", "✌️", "✋"]

    @State private var playerChoice = 0
    @State private var playerShouldWin = false
    @State private var displayAlert = false
    @State private var score = 0
    @State private var round = 1
    @State private var botChoice = ""

    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Round \(round)")
            }
            .padding()
            if round == 10 {
                Text("Your Score: \(score)")
            }

            Text("Bot Choice:").padding()
            Text(botChoice)
                .onReceive(timer) { _ in
                    if !displayAlert {
                        botChoice = choices[Int.random(in: 0 ... 2)]
                    }
                }.font(.largeTitle.weight(.heavy))

            Spacer()

            Text("Your Choice:").padding()
            HStack {
                ForEach(0 ..< 3) { userChoice in
                    ChoiceView(choice: choices[userChoice],
                               isPresented: $displayAlert,
                               shouldWin: $playerShouldWin)
                    {
                        if round < 10 {
                            playerShouldWin = Bool.random()
                            displayAlert = true
                            if playerShouldWin {
                                score += 1
                                botChoice = choices[(userChoice + 3 + 1) % 3]
                            } else {
                                botChoice = choices[(userChoice + 3 - 1) % 3]
                            }
                            round += 1
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
