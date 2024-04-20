//
//  ContentView.swift
//  BetterRest
//
//  Created by Sreekutty Maya on 20/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = NSDate.now

    var body: some View {
        VStack(alignment:.center) {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,in:4...12,step: 0.25)
            let tomorrow = Date.now.addingTimeInterval(86400)

            // create a range from those two
            let components = Calendar.current.dateComponents([.hour, .minute], from: caluclateDate())
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))


        }.padding()
    }
    
    func caluclateDate()  -> Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
        return date
    }
}

#Preview {
    ContentView()
}
