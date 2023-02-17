//
//  GameRunner.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/16/23.
//

import Foundation

class GameDriver {
    let game: Game
    var gameTimer: Timer
    var playTimer: Timer
    var timeoutTimer: Timer?
    let playClock: PlayClock
    let gameClock: Clock
    let timeoutClock: Clock
    
    
    init(game: Game, gameTimer: Timer, playTimer: Timer, timeoutTimer: Timer? = nil, playClock: PlayClock, gameClock: Clock, timeoutClock: Clock) {
        self.game = game
        self.gameTimer = gameTimer
        self.playTimer = playTimer
        self.timeoutTimer = timeoutTimer
        self.playClock = playClock
        self.gameClock = gameClock
        self.timeoutClock = timeoutClock
    }
    
    func start(){
        self.gameClock.start()
        self.playClock.start()
    }
    
    func timeout(){
        self.timeout()
    }
    
    
    @objc
    func countDownGameClock(){
        if(!self.gameClock.up() && self.gameClock.isRunning()){
            self.gameClock.countDown()
        }
    }
    
    
    @objc
    func countDownPlayClock(){
        if(!self.playClock.up() && self.playClock.isRunning()){
            self.playClock.countDown()
        }
    }
    func flag(){
        gameClock.pause()
    }
    func incomplete(){
        gameClock.pause()
    }
    func score(){
        gameClock.pause()
    }
}
