import SwiftUI
import WatchKit
import Combine

struct ContentView: View {
    @State private var storedTalkTime: Int = UserDefaults.standard.integer(forKey: "storedTalkTime")
    @State var talkTime: Int = 5
    @State var remainingTime: Int = 60
    @State var timerActive = false
    @State private var timer: Timer? = nil
    @State private var session: WKExtendedRuntimeSession?
    
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
                        ForEach(3..<61, id: \.self) { i in
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
            
            Text("Reminder every \(calcReminders()) min")
                .foregroundColor(timerActive ? .red : .primary)
            
            Spacer()
            
            Button {
                if (storedTalkTime != talkTime) {
                    saveValue(value: talkTime)
                    return
                }
                
                timerActive.toggle()
                
                if (timerActive) {
                    startTimer()
                    WKInterfaceDevice.current().play(.start)
                }
                else {
                    stopTimer()
                    WKInterfaceDevice.current().play(.stop)
                }
                
            } label: {
                if (storedTalkTime != talkTime) {
                    Text("Prepare Talk")
                }
                else if (timerActive) {
                    Text("Stop Talk")
                }
                else {
                    Text("Start Talk")
                }
            }
        }
        .onAppear
        {
            loadValue()
        }
    }
    
    private func startTimer() {
        remainingTime = talkTime - 1
        let reminders = calcReminders()
        // ensure the timer is stopped
        stopTimer()
        
        // create the new timer
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            // we get notified 1 a minute
            // reduce 1 minute of remaining time
            remainingTime -= 1
            if remainingTime > 0 {                
                // we need to notify
                if (remainingTime % reminders == 0) {
                    let progress = remainingTime / reminders
                    playHapticFeedback(.directionUp, count: progress, delay: 0.5);
                }
            } else {
                // done, sucessfully
                stopTimer(true)
            }
        }
        
        let session = WKExtendedRuntimeSession()
        session.delegate = WKExtension.shared().delegate as? WKExtendedRuntimeSessionDelegate
        session.start()
        self.session = session
    }
    
    func playHapticFeedback(_ hapticType: WKHapticType, count: Int, delay: TimeInterval) {
        let device = WKInterfaceDevice.current()
        
        if count > 0 {
            device.play(hapticType)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.playHapticFeedback(hapticType, count: count - 1, delay: delay)
            }
        }
    }

    private func stopTimer(_ success: Bool = false) {
        timerActive = false
        timer?.invalidate()
        timer = nil
        session?.invalidate()
        saveValue(value: 0)

        if (success) {
            playHapticFeedback(.success, count: 2, delay: 1);
        }
    }

    private func calcReminders() -> Int {
        if (talkTime < 4) {
            return 1;
        }

        return talkTime / 4
    }
    
    private func loadValue() {
        storedTalkTime = UserDefaults.standard.integer(forKey: "storedTalkTime")
        if (storedTalkTime > 0) {
            talkTime = storedTalkTime
            //startTimer()
        }
    }
    private func saveValue(value: Int) {
        UserDefaults.standard.setValue(value, forKey: "storedTalkTime")
        loadValue()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
