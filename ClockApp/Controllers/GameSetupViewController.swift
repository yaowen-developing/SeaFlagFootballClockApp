//
//  GameSetupViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/18/23.
//

import UIKit

class GameSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.addTargets()
    }
    
    func setupViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.shortMinutesSetupSlider)
        self.view.addSubview(self.shortMinutesWarningLabel)
        self.view.addSubview(self.quarterDurationSetupLabel)
        self.view.addSubview(self.quarterDurationSlider)
        self.view.addSubview(self.createButton)
        self.view.addSubview(self.clockStoppageRangeSetupLabel)
        self.view.addSubview(self.clockStoppageRangeSlider)
    }
    
    func addTargets(){
        self.shortMinutesSetupSlider.addTarget(self, action: #selector(changeShortMinutesSetup), for: .valueChanged)
        self.quarterDurationSlider.addTarget(self, action: #selector(changeQuarterDurationSetup), for: .valueChanged)
        self.clockStoppageRangeSlider.addTarget(self, action: #selector(changeClockStoppageRangeSetup), for: .valueChanged)
        self.createButton.addTarget(self, action: #selector(createGame), for: .touchDown)
    }
    
    @objc
    func changeShortMinutesSetup(){
        self.shortMinutesWarningLabel.text = "Warning at Minute " + String(describing: Int(self.shortMinutesSetupSlider.value))
    }
    
    @objc
    func changeClockStoppageRangeSetup(){
        self.clockStoppageRangeSetupLabel.text = "Stoppage range: " + String(describing: Int(self.clockStoppageRangeSlider.value))
    }
    
    @objc
    func createGame(){
        let vc = ClockBoardViewController(game: Game(quarterDuration: Decimal(Int(self.quarterDurationSlider.value) * 60), playClockDuration: 40, stoppageLineInMin: Int(self.clockStoppageRangeSlider.value), warningLineInMin: Int(self.shortMinutesSetupSlider.value)))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc
    func changeQuarterDurationSetup(){
        self.quarterDurationSetupLabel.text = "Minutes per quarter: " + String(describing: Int(self.quarterDurationSlider.value))
    }
    
    lazy var shortMinutesWarningLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 100, width: self.view.frame.width-100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Warning at Minute 2"
        return label
    }()
    
    lazy var shortMinutesSetupSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 50, y: 200, width: self.view.frame.width - 100, height: 50))
        slider.maximumValue = 5
        slider.minimumValue = 0
        slider.value = 2
        return slider
    }()
    
    lazy var quarterDurationSetupLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 250, width: self.view.frame.width - 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Minutes per quarter: 8"
        return label
    }()
    
    lazy var quarterDurationSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 50, y: 350, width: self.view.frame.width - 100, height: 50))
        slider.maximumValue = 20
        slider.minimumValue = 5
        slider.value = 8
        return slider
    }()
    
    lazy var clockStoppageRangeSetupLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 400, width: self.view.frame.width - 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Stoppage range: 2"
        return label
    }()
    
    lazy var clockStoppageRangeSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 50, y: 500, width: self.view.frame.width - 100, height: 50))
        slider.maximumValue = 5
        slider.minimumValue = 1
        slider.value = 2
        return slider
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 600, width: self.view.frame.width - 160, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 8
        return button
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
