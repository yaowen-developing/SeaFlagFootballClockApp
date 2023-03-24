//
//  Game.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/16/23.
//

import Foundation

class Game {
    let numOfQuarters: Int?
    let quarterDuration: Decimal
    let playClockDuration: Decimal
    
    let stoppageLineInMin: Int
    let warningLineInMin: Int
    
    enum GameState {
        case running
        case paused
        case refOperating
    }
    
    init(numOfQuarters: Int = 4, quarterDuration: Decimal, playClockDuration: Decimal, stoppageLineInMin: Int, warningLineInMin: Int) {
        self.numOfQuarters = numOfQuarters
        self.quarterDuration = quarterDuration
        self.playClockDuration = playClockDuration
        self.stoppageLineInMin = stoppageLineInMin
        self.warningLineInMin = warningLineInMin
    }
}
