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
            let range = Date.now...tomorrow
            DatePicker("", selection: $wakeUp,in: Date.now...).labelsHidden()
            DatePicker("", selection: $wakeUp,in: Date.now...).labelsHidden()
            DatePicker("", selection: $wakeUp,displayedComponents: .date).labelsHidden()
            DatePicker("select date", selection: $wakeUp,in: Date.now...)


        }.padding()
    }
}

#Preview {
    ContentView()
}
