//
//  ClockViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import UIKit
import AVFoundation


class ClockBoardViewController: UIViewController, ClockPresenter, RefOperationExecutor {

    


    var gameDriver: GameDriver?
    
    convenience init(){
        self.init(game: nil)
    }
    
    init(game: Game?) {
        super.init(nibName: nil, bundle: nil)
        gameDriver = GameDriver(game: game!)
        gameDriver!.start()
        gameDriver?.registerGameClockPresenter(presenter: self)
        gameDriver?.registerPlayClockPresenter(presenter: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
        // Do any additional setup after loading the view.
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(operate))
        tap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tap)
    }
    func setupViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(gameClockLabel)
        self.view.addSubview(playClockLabel)
    }
    
    @objc
    func operate(){
        //presents menu
        gameDriver?.snapshotClocks()
        let vc = RefOperationPanelViewController(refOperationExecutor: self)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    func flag() {
        gameDriver?.flag()
        gameDriver?.rollbackGameClock()
    }
    
    func timeout() {
        gameDriver?.timeout()
        gameDriver?.rollbackPlayClock()
        gameDriver?.rollbackGameClock()
    }
    
    
    
    
    func incomplete(){
    }
    
    
    func warnShortTime() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1000)
    }
    
    func alertGameTimeup(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1050)
    }
    
    func alertPlayClockTimeup() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1080)
    }
    
    
    func updatePlayClockView(timeString: String) {
        playClockLabel.text = timeString
    }
    func updateGameClockView(timeString: String) {
        gameClockLabel.text = timeString
    }
    
    lazy var gameClockLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height / 2))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var playClockLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 100 + self.view.frame.height / 2, width: self.view.frame.width, height: 200))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        label.textColor = .black
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
