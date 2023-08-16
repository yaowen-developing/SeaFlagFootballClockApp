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
    private var clockSnapshots: [ClockSnapshot]
    
    struct ClockSnapshot {
        var gameClockRemainingTime: Decimal?
        var playClockRemainingTime: Decimal?
    }
    
    init(game: Game) {
        self.game = game
        self.playClock = PlayClock(game: game)
        self.gameClock = GameClock(game: game)
        self.timeoutClock = GameClock(game: game)
        self.clockSnapshots = [ClockSnapshot(gameClockRemainingTime: gameClock.remaining, playClockRemainingTime: playClock.remaining)]
        self.loadClocks()
    }
    
    
    func loadClocks() {
        self.gameClock.load()
        self.playClock.load()
    }
    
    func registerGameClockPresenter(presenter: ClockPresenter){
        self.gameClock.registerPresenter(presenter: presenter)
    }
    
    func registerPlayClockPresenter(presenter: ClockPresenter){
        self.playClock.registerPresenter(presenter: presenter)
    }
    
    func updateInitialBoardView(){
        self.gameClock.updateClockPresenters()
        self.playClock.updateClockPresenters()
    }
    
    func start(){
        self.gameClock.start()
        self.playClock.start()
    }
    
    func pause(){
        self.gameClock.pause()
        self.playClock.pause()
    }
    
    func rollbackGameClock(row: Int){
        self.gameClock.pause()
        self.gameClock.remaining = self.clockSnapshots[row].gameClockRemainingTime!
        self.gameClock.updateGameClockPresenters()
    }
    
    func startPausePlayClock(){
        if(self.playClock.isRunning()){
            self.playClock.pause()
        }
        else{
            self.playClock.start()
        }
    }
    
    func startPauseGameClock(){
        if(self.gameClock.isRunning()){
            self.gameClock.pause()
        }
        else{
            self.gameClock.start()
        }
    }
    
    func rollbackPlayClock(){
        self.playClock.remaining = self.clockSnapshots[0].playClockRemainingTime!
        self.playClock.updatePlayClockPresenters()
    }
    
    func snapshotClocks(){
        self.clockSnapshots.insert(ClockSnapshot(gameClockRemainingTime: self.gameClock.remaining, playClockRemainingTime: self.playClock.remaining), at: 1)
    }
    
    func isWithinStoppageRange() -> Bool{
        return self.gameClock.isWithinWarningTimeWindow()
    }
    
    func resetPlayClock(){
        if(self.playClock.isRunning()){
            return
        }
        self.playClock.remaining = self.playClock.duration
        self.playClock.updateClockPresenters()
    }
    
    func setPlayClockDuration(duration: Decimal){
        self.playClock.setDuration(duration: duration)
    }
    
    func getSnapshots() -> [ClockSnapshot]{
        return self.clockSnapshots
    }
    
    func getHomeTeam() -> String {
        return self.game.homeTeam
    }
    
    func getAwayTeam() -> String {
        return self.game.awayTeam
    }
}
