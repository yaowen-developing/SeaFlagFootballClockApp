//
//  ClockViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import UIKit
import AVFoundation

class ClockBoardViewController: UIViewController {

    var countdown: Int?
    var countdown2: Int?
    var running: Bool?
    
    private var gameClock: Clock
    private var playClock: Clock
    
    convenience init(){
        self.init(gameClock: nil, playClock: nil)
    }
    
    init(gameClock: Clock?, playClock: Clock?) {
        self.gameClock = gameClock!
        self.playClock = playClock!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(clockLabel)
        self.view.addSubview(clockLabel2)
        
        running = true
        countdown = 10
        countdown2 = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(startPause))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        var timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        var timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown2), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func countDown(){
        if(running! && countdown! > 0){
            countdown! -= 1
            clockLabel.text = String(countdown!)
        }

    
    }
    
    @objc
    func countDown2(){
        if(running! && countdown2! > 0){
            countdown2! -= 1
            clockLabel2.text = String(countdown2!)
        }
        if(countdown == 0){
    
           AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

        }
    }
    
    @objc
    func startPause(){
        running = !running!
    }
    
    
    lazy var clockLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is label view."
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var clockLabel2: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is label view."
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
