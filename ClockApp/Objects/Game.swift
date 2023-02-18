//
//  Game.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/16/23.
//

import Foundation

class Game {
    let numOfQuarters: Int
    let quarterLength: Decimal
    let playClockLength: Decimal
    
    let stoppageLineInMin: Int
    let warningLineInMin: Int
    let quarterBreakLength: Int
    let halfBreakLength: Int
    let timeoutLength: Int
    let timeoutLimit: Int
    

    
    enum GameState {
        case running
        case paused
        case refOperating
    }
    
    
    init(numOfQuarters: Int, quarterLength: Decimal, playClockLength: Decimal, stoppageLineInMin: Int, warningLineInMin: Int, quarterBreakLength: Int, halfBreakLength: Int, timeoutLength: Int, timeoutLimit: Int) {
        self.numOfQuarters = numOfQuarters
        self.quarterLength = quarterLength
        self.playClockLength = playClockLength
        self.stoppageLineInMin = stoppageLineInMin
        self.warningLineInMin = warningLineInMin
        self.quarterBreakLength = quarterBreakLength
        self.halfBreakLength = halfBreakLength
        self.timeoutLength = timeoutLength
        self.timeoutLimit = timeoutLimit
    }
    

    func timeout() -> Bool {
        return true
    }
    func flag(){
    }
    func incomplete(){
    }
    func score(){
    }
}
