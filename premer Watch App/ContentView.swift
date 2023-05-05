//
//  ContentView.swift
//  premer Watch App
//
//  Created by Klaus on 2023-05-05.
//

import SwiftUI
import WatchKit
import Combine

struct ContentView: View {
    @State var talkTime: Int = 5
    @State var remainingTime: Int = 60
    @State var timerActive = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Image(systemName: "quote.opening")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            if (timerActive) {
                Text("Remaining (min)")
            }
            else{
                Text("Time (min)")
            }
            
            HStack {
                Spacer()
                if (!timerActive){
                    Picker(selection: $talkTime, label: Text("Time")) {
                        ForEach(1..<61, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: 100)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 4)
                            .frame(width: 100, height: 50)
                        
                        Text("\(remainingTime)")
                            .font(.largeTitle)
                            .foregroundColor(Color.red)
                    }
                }
                Spacer()
            }
            
            Text("Reminder every \(reminders()) min")
                .foregroundColor(timerActive ? .red : .primary)
            
            Spacer()
            
            Button {
                timerActive.toggle()
                
                if (timerActive){
                    startTimer()
                }
                else {
                    stopTimer()
                }
                
            } label: {
                if (timerActive) {
                    Text("Stop Talk")
                }
                else{
                    Text("Start Talk")
                }
            }
        }
    }
    
    private func startTimer() {
        remainingTime = talkTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        timerActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func reminders() -> Int {
        if (talkTime < 4) {
            return 1;
        }
        
        return talkTime / 4
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
