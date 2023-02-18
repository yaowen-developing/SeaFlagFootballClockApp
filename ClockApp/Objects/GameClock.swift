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
}

class GameClock {
    var length: Decimal
    var remaining: Decimal
    var state: ClockState
    var timer: Timer?
    var presenters: [ClockPresenter]
    weak var game: Game?
    init(game: Game) {
        self.game = game
        self.length = game.quarterLength
        self.remaining = game.quarterLength
        self.state = ClockState.paused
        presenters = []
    }
    
    func registerPresenter(presenter: ClockPresenter){
        presenters.append(presenter)
    }
    
    func load(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    func start(){
        self.state = ClockState.running
    }
    func pause(){
        self.state = ClockState.paused
    }
    func reset(){
        pause()
        self.remaining = length
        self.updateGameClockPresenters()
    }
    
    func getTimeString() -> String{
        return String(format: "%d:%0.2d", remaining.int / 60, remaining.int % 60)
    }
    
    func isRunning() -> Bool {
        return self.state == ClockState.running
    }
    
    func updateClockPresenters(){
        if(remaining == 0){
            self.state = .ended
            alertGameTimeup()
        }
        else if(withinWarningTimeWindow()){
            shortTimeWarning()
        }
        else{
            updateGameClockPresenters()
        }
    }
    
    
    func shortTimeWarning(){
        for presenter in presenters {
            presenter.warnShortTime?()
        }
    }
    
    func alertGameTimeup(){
        for presenter in presenters {
            presenter.alertGameTimeup?()
        }
    }
    
    func updateGameClockPresenters() {
        for presenter in presenters {
            presenter.updateGameClockView?(timeString: getTimeString())
        }
    }
    
    func withinWarningTimeWindow() -> Bool{
        return game!.warningLineInMin > 0 && remaining == Decimal(game!.warningLineInMin * 60)
    }
    
    func shouldCountdown() -> Bool {
        return self.isRunning()
    }
    
    @objc
    func countdown(){
        if(shouldCountdown()){
            self.remaining -= 0.1
            updateClockPresenters()
        }
    }
}

