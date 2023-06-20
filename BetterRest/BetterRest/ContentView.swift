//
//  ContentView.swift
//  BetterRest
//
//  Created by Alvin Wo on 2023/6/16.
//
import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1

    private var alertMessage: String {
        return calculateBedtime()
    }

    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("When do you want to wake up?")) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }

                    Section(header: Text("Desired amount of sleep:")) {
                        Picker("Optionns", selection: $sleepAmount) {
                            ForEach(Array(stride(from: 4.0, to: 12.0, by: 0.5)), id: \.self) { value in
                                Text("\(value, specifier: "%.1f")").tag(value)
                            }
                        }
                    }

                    Section(header: Text("Daily coffee intake:")) {
                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1 ... 20)
                    }
                    HStack {
                        Text("The time to sleep")
                        Spacer()
                        Text(alertMessage).font(.headline)
                    }
                }
            }
        }
    }

    func calculateBedtime() -> String {
        var alertMessage = ""
        do {
            let confg = MLModelConfiguration()
            let model = try SleepCalculator(configuration: confg)

            // more code to come here
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        return alertMessage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
