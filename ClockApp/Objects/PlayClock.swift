//
//  PlayClock.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/17/23.
//

import Foundation

class PlayClock: GameClock{
    override init(game: Game) {
        super.init(game: game)
        self.duration = game.playClockDuration
        self.remaining = game.playClockDuration
    }
    
    override func updateClockPresenters(){
        if(remaining == 0){
            self.state = .ended
            self.alertPlayClockTimeup()
        }
        else{
            self.updatePlayClockPresenters()
        }
    }
    
    func updatePlayClockPresenters() {
        for presenter in self.presenters {
            presenter.updatePlayClockView?(timeString: self.remaining.timeString)
        }
    }
    
    func alertPlayClockTimeup() {
        for presenter in self.presenters {
            presenter.alertPlayClockTimeup?()
        }
    }
    
    func setDuration(duration: Decimal){
        self.duration = duration
    }
    
    override func reset() {
        self.remaining = self.duration;
        self.updateGameClockPresenters()
    }
}
