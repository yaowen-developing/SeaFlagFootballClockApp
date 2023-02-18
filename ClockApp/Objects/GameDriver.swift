//
//  GameRunner.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/16/23.
//

import Foundation
import UIKit

class GameDriver {
    private let game: Game
    private let playClock: PlayClock
    private let gameClock: GameClock
    private let timeoutClock: GameClock
    private var clockSnapshots: ClockSnapshots
    
    struct ClockSnapshots {
        var gameClockRemainingTime: Decimal?
        var playClockRemainingTime: Decimal?
    }
    
    init(game: Game) {
        self.game = game
        self.playClock = PlayClock(game: game)
        self.gameClock = GameClock(game: game)
        self.timeoutClock = GameClock(game: game)
        self.clockSnapshots = ClockSnapshots()
        loadClocks()
    }
    
    
    func loadClocks() {
        self.gameClock.load()
        self.playClock.load()
    }
    
    func registerGameClockPresenter(presenter: ClockPresenter){
        gameClock.registerPresenter(presenter: presenter)
    }
    func registerPlayClockPresenter(presenter: ClockPresenter){
        playClock.registerPresenter(presenter: presenter)
    }
    
    func start(){
        self.gameClock.start()
        self.playClock.start()
    }
    
    func timeout(){
        gameClock.pause()
        playClock.pause()
    }
    
    func flag(){
        gameClock.pause()
        game.flag()
    }
    func incomplete(){
        gameClock.pause()
        game.incomplete()
    }
    func score(){
        gameClock.pause()
        game.score()
    }
    func rollbackGameClock(){
        gameClock.remaining = clockSnapshots.gameClockRemainingTime!
        gameClock.updateGameClockPresenters()
    }
    
    func rollbackPlayClock(){
        playClock.remaining = clockSnapshots.playClockRemainingTime!
        playClock.updatePlayClockPresenters()
    }
    
    func snapshotClocks(){
        clockSnapshots.gameClockRemainingTime = gameClock.remaining
        clockSnapshots.playClockRemainingTime = playClock.remaining
    }
    
    func withinStoppageRange() -> Bool{
        return gameClock.remaining <= Decimal(game.stoppageLineInMin * 60)
    }
}
