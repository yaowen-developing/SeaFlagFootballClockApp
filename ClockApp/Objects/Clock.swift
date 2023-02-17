//
//  Clock.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import Foundation

enum ClockState {
    case running
    case paused
    case ended
    case standBy
}
class PlayClock: Clock{
    override func getTimeString() -> String {
        return String(format: "%d", Int(ceil(remaining)))
    }
}
class Clock {
    let length: Float
    var remaining: Float
    var state: ClockState
    
    init(length: Float) {
        self.length = length
        self.remaining = length
        self.state = ClockState.standBy
    }
    
    func start(){
        self.state = ClockState.running
    }
    func pause(){
        self.state = ClockState.paused
    }
    func reset(){
        self.remaining = length
        self.state = ClockState.standBy
    }
    
    func getTimeString() -> String{
        return String(format: "%d:%0.2d", Int(ceil(remaining)) / 60, Int(ceil(remaining))%60)
    }
    
    func isRunning() -> Bool {
        return self.state == ClockState.running
    }
    
    func countDown(){
        if(up()){
            return
        }
        self.remaining -= 0.1
    }
    func up() -> Bool {
        return self.remaining <= 0
    }
}
