//
//  ClockViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import UIKit
import AVFoundation


class ClockBoardViewController: UIViewController, ClockPresenter{
    
    var gameDriver: GameDriver?
    
    convenience init(){
        self.init(game: nil)
    }
    init(game: Game?) {
        super.init(nibName: nil, bundle: nil)
        self.gameDriver = GameDriver(game: game!)
        self.gameDriver?.registerGameClockPresenter(presenter: self)
        self.gameDriver?.registerPlayClockPresenter(presenter: self)
        self.playClockDurationSegments.selectedSegmentIndex = 0
        self.gameDriver?.updateInitialBoardView()
        self.snapShotsTableView.dataSource = self
        self.snapShotsTableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        self.view.backgroundColor = .white
        self.addViews()
        self.layoutViews()
        self.setupGestures()
    }

    func layoutViews(){
        self.playClockTitleLabel.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        self.playClockButton.frame = CGRect(x: 100, y: self.playClockTitleLabel.frame.maxY + 10, width: self.view.frame.width - 200, height: 100)
        self.playClockDurationSegments.frame = CGRect(x: 100, y: self.playClockButton.frame.maxY + 10, width: self.view.frame.width - 200, height: 40)
        self.gameClockTitleLabl.frame = CGRect(x: 0, y: self.playClockDurationSegments.frame.maxY + 30, width: self.view.frame.width, height: 50)
        self.gameClockButton.frame = CGRect(x: 50, y: self.gameClockTitleLabl.frame.maxY + 10, width: self.view.frame.width - 100, height: 150)
        self.gameClockSnapshotsButton.frame = CGRect(x: 50, y: self.gameClockButton.frame.maxY + 10, width: self.view.frame.width - 100, height: 60)
        self.snapShotsTableView.frame = CGRect(x: 50, y: self.gameClockSnapshotsButton.frame.maxY + 10, width: self.view.frame.width - 100, height: self.view.frame.height - 150 - self.gameClockSnapshotsButton.frame.maxY)
        
        self.homeTeamLabel.frame = CGRect(x: 25, y: self.snapShotsTableView.frame.maxY + 10, width: self.view.frame.width / 2 - 20, height: 50)
        self.homeTeamLabel.text = (self.gameDriver?.getHomeTeam())! + "(Home)"
        self.homeScore.frame = CGRect(x:25, y: self.homeTeamLabel.frame.maxY + 10, width:50,height:50)
        
        self.awayTeamLabel.frame = CGRect(x: self.view.frame.width / 2 + 10, y: self.snapShotsTableView.frame.maxY + 10, width: self.view.frame.width / 2 - 20, height: 50)
        self.awayTeamLabel.text = (self.gameDriver?.getAwayTeam())! + "(Away)"
        self.awayScore.frame = CGRect(x: self.view.frame.width / 2 + 10, y: self.awayTeamLabel.frame.maxY + 10, width: 50, height: 50)
    }
    
    func addViews(){
        self.view.addSubview(self.playClockTitleLabel)
        self.view.addSubview(self.playClockButton)
        self.view.addSubview(self.self.playClockDurationSegments)
        self.view.addSubview(self.gameClockTitleLabl)
        self.view.addSubview(self.gameClockButton)
        self.view.addSubview(self.gameClockSnapshotsButton)
        self.view.addSubview(self.snapShotsTableView)
        
        self.view.addSubview(self.homeTeamLabel)
        self.view.addSubview(self.awayTeamLabel)
        
        self.view.addSubview(self.homeScore)
        self.view.addSubview(self.awayScore)
    }
    
    func setupGestures(){
        self.setupPlayClockGestures()
        self.setupGameClockGestures()
        self.setupGameClockSnapshotButtonGestures()
        self.playClockDurationSegments.addTarget(self, action: #selector(switchPlayClockDuration), for: .valueChanged)
    }
    
    func setupGameClockGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(startPauseGameClock))
        tap.numberOfTapsRequired = 2
        self.gameClockButton.addGestureRecognizer(tap)
    }
    
    func setupPlayClockGestures(){
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(resetPlayClock))
        longpress.minimumPressDuration = 1.5
        self.playClockButton.addGestureRecognizer(longpress)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(startPausePlayClock))
        tap.numberOfTapsRequired = 2
        self.playClockButton.addGestureRecognizer(tap)
    }
    
    func setupGameClockSnapshotButtonGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(snapshotClocks))
        tap.numberOfTapsRequired = 2
        self.gameClockSnapshotsButton.addGestureRecognizer(tap)
    }
    
    
    func warnShortTime() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1000)
    }
    
    func alertGameTimeup(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1005)
    }
    
    func alertPlayClockTimeup() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1005)
    }
    
    func alertDoubleClickOnClock(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1004)
    }
    
    func alertDoubleClickOnSnapshot(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1003)
    }
    
    func updatePlayClockView(timeString: String) {
        self.playClockButton.setTitle(timeString, for: .normal)
    }
    
    func updateGameClockView(timeString: String) {
        self.gameClockButton.setTitle(timeString, for: .normal)
    }
    
    @objc
    func resetPlayClock(){
        self.gameDriver?.resetPlayClock()
    }

    @objc
    func switchPlayClockDuration(){
        if(self.playClockDurationSegments.selectedSegmentIndex == 0){
            self.gameDriver?.setPlayClockDuration(duration: 40)
        }
        else{
            self.gameDriver?.setPlayClockDuration(duration: 25)
        }
    }
    
    @objc
    func startPausePlayClock(){
        self.gameDriver?.startPausePlayClock()
        self.alertDoubleClickOnClock()
    }
    
    @objc
    func startPauseGameClock(){
        self.gameDriver?.startPauseGameClock()
        self.alertDoubleClickOnClock()
    }
    
    @objc
    func snapshotClocks(){
        self.gameDriver?.snapshotClocks()
        self.snapShotsTableView.reloadData()
        self.alertDoubleClickOnSnapshot()
    }
    
    var playClockTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Play Clock"
        return label
    }()
    
    var playClockButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        button.backgroundColor = .gray
        return button
    }()

    var playClockDurationSegments: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["40", "25"])
        segmentControl.selectedSegmentTintColor = .systemBlue
        return segmentControl
    }()
    
    var gameClockTitleLabl: UILabel = {
        let label = UILabel()
        label.text = "Game Clock"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var gameClockButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        button.backgroundColor = .gray
        return button
    }()
    
    var gameClockSnapshotsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Snapshot", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    var homeTeamLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var awayTeamLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var homeScore: UITextField = {
        let input = UITextField()
        input.text = "0"
        input.keyboardType = UIKeyboardType.numberPad
        return input
    }()
    
    var awayScore: UITextField = {
        let input = UITextField()
        input.text = "0"
        input.keyboardType = UIKeyboardType.numberPad
        return input
    }()

    var snapShotsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
}

extension ClockBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Rewind", handler:
            {_,_,completionHandler in
                self.gameDriver?.rollbackGameClock(row: indexPath.row)
                completionHandler(true)
            })
        action.backgroundColor = .systemOrange
        let configurations = UISwipeActionsConfiguration(actions: [action])
        configurations.performsFirstActionWithFullSwipe = false
        return configurations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameDriver!.getSnapshots().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (self.gameDriver?.getSnapshots()[indexPath.row].gameClockRemainingTime)!.timeString
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    
}
