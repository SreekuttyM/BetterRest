//
//  ContentView.swift
//  BetterRest
//
//  Created by Sreekutty Maya on 20/04/2024.
//

import SwiftUI
import CoreML

struct ContentView: View {
    static var defaultWakeTime: Date {
         var components = DateComponents()
         components.hour = 7
         components.minute = 0
         return Calendar.current.date(from: components) ?? .now
     }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
  
    var body: some View {
        NavigationStack {
                Form {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("When do you want to wake Up?").font(.headline)
                        DatePicker("Select Date", selection: $wakeUp,displayedComponents: .hourAndMinute).labelsHidden()
                    }
                    Text("Desired Amount of sleep").font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,in:4...12,step: 0.25) { _ in
                        calculateSleep()

                    }
                    Text("Daily Coffee Intake").font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount,in:1...20) {_ in 
                        calculateSleep()

                    }
                    
                }.alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }.padding()
                    .toolbar {
                        Button("Calculate", action: calculateSleep)
                    }
        }.navigationTitle("Better Rest")
         
       
        
    }
    
    func calculateSleep() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            showingAlert = true

        } catch {
            // something went wrong!
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true

            
        }
        

    }
}

#Preview {
    ContentView()
}
