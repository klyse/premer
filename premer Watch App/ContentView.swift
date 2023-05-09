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
            gotFocus()
        }
        .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)) { _ in
            gotFocus()
        }
        .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidEnterBackgroundNotification)) { _ in
            lostFocus()
        }
    }
    
    private func startTimer() {
        remainingTime = talkTime - 1
        let reminders = calcReminders()
        // ensure the timer is stopped
        stopTimer()
        
        timerActive = true
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
                resetConfig()
            }
        }
        
        let newSession = WKExtendedRuntimeSession()
        newSession.delegate = WKExtension.shared().delegate as? WKExtendedRuntimeSessionDelegate
        newSession.start()
        
        session = newSession
    }
    
    private func stopTimer(_ success: Bool = false) {
        timerActive = false
        timer?.invalidate()
        timer = nil
        
        if (session != nil && (
            session?.state == WKExtendedRuntimeSessionState.scheduled ||
            session?.state == WKExtendedRuntimeSessionState.running)) {
            session?.invalidate()
        }
        
        
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
    
    private func gotFocus() {
        storedTalkTime = UserDefaults.standard.integer(forKey: "storedTalkTime")
        
        if (timerActive) {
            return
        }
        
        loadValue()
        
        // everything ready to start a new session
        if (storedTalkTime > 0) {
            talkTime = storedTalkTime
            startTimer()
        }
    }
    
    private func lostFocus() {
        if (timerActive) {
            return
        }
        
        if (storedTalkTime == talkTime) {
            return
        }
        
        // reset to a default as the user has not saved
        saveValue(value: 0)
    }
    
    private func resetConfig() {
        saveValue(value: 0)
    }
    
    private func loadValue() {
        storedTalkTime = UserDefaults.standard.integer(forKey: "storedTalkTime")
    }
    private func saveValue(value: Int) {
        UserDefaults.standard.setValue(value, forKey: "storedTalkTime")
        storedTalkTime = value
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
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
