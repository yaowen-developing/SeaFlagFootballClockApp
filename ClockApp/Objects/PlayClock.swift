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
        self.length = game.playClockLength
        self.remaining = game.playClockLength
    }
    
    override func updateClockPresenters(){
        if(remaining == 0){
            self.state = .ended
            alertPlayClockTimeup()
        }
        else{
            updatePlayClockPresenters()
        }
    }
    
    
    func updatePlayClockPresenters() {
        for presenter in presenters {
            presenter.updatePlayClockView?(timeString: getTimeString())
        }
    }
    
    func alertPlayClockTimeup() {
        for presenter in presenters {
            presenter.alertPlayClockTimeup?()
        }
    }
//    override func getTimeString() -> String {
//        return String(format: "%d", remaining.int)
//    }
    override func reset() {
        self.remaining = length;
        self.updateGameClockPresenters()
    }
}
