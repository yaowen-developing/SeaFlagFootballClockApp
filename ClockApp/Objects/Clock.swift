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
class Clock {
    let length: Int
    var remaining: Int
    var state: ClockState
    
    init(length: Int) {
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
        return String(format: "%d:%0.2d", remaining / 60, remaining % 60)
    }
    
    func countDown(){
        if(up()){
            return
        }
        self.remaining -= 1
    }
    func up() -> Bool {
        return self.remaining == 0
    }
}
