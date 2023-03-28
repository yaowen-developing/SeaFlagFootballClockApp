//
//  Clock.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import Foundation
import UIKit

enum ClockState {
    case running
    case paused
    case ended
}

@objc protocol ClockPresenter {
    @objc optional func updateGameClockView(timeString: String)
    @objc optional func updatePlayClockView(timeString: String)
    @objc optional func warnShortTime()
    @objc optional func alertGameTimeup()
    @objc optional func alertPlayClockTimeup()
    @objc optional func alertClockStart()
    @objc optional func alertClockStop()
}

class GameClock {
    
    var duration: Decimal
    var remaining: Decimal
    var state: ClockState
    var timer: Timer?
    var presenters: [ClockPresenter]
    weak var game: Game?
    
    init(game: Game) {
        self.game = game
        self.duration = game.quarterDuration
        self.remaining = game.quarterDuration
        self.state = ClockState.paused
        self.presenters = []
    }
    
    func registerPresenter(presenter: ClockPresenter){
        self.presenters.append(presenter)
    }
    
    func load(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    func start(){
        self.state = ClockState.running
        for presenter in self.presenters {
            presenter.alertClockStart?()
        }
    }
    
    func pause(){
        self.state = ClockState.paused
        for presenter in self.presenters {
            presenter.alertClockStop?()
        }
    }
    
    func reset(){
        self.pause()
        self.remaining = duration
        self.updateGameClockPresenters()
    }
    
    func isRunning() -> Bool {
        return self.state == ClockState.running
    }
    
    func updateClockPresenters(){
        if(self.remaining == 0){
            self.state = .ended
            self.alertGameTimeup()
        }
        else if(self.isWithinWarningTimeWindow()){
            self.shortTimeWarning()
        }
        else{
            self.updateGameClockPresenters()
        }
    }
    
    func shortTimeWarning(){
        for presenter in self.presenters {
            presenter.warnShortTime?()
        }
    }
    
    func alertGameTimeup(){
        for presenter in self.presenters {
            presenter.alertGameTimeup?()
        }
    }
    
    func updateGameClockPresenters() {
        for presenter in self.presenters {
            presenter.updateGameClockView?(timeString: remaining.timeString)
        }
    }
    
    func isWithinWarningTimeWindow() -> Bool{
        return self.game!.warningLineInMin > 0 && self.remaining == Decimal(game!.warningLineInMin * 60)
    }
    
    func shouldCountdown() -> Bool {
        return self.isRunning()
    }
    
    @objc
    func countdown(){
        if(self.shouldCountdown() && self.remaining > 0){
            self.remaining -= 0.1
            self.updateClockPresenters()
        }
    }
}

