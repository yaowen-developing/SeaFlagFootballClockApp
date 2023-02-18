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
        self.view.backgroundColor = .white
        self.view.addSubview(shortMinutesSetupSlider)
        shortMinutesSetupSlider.addTarget(self, action: #selector(changeShortMinutesSetup), for: .valueChanged)
        self.view.addSubview(shortMinutesWarningLabel)
        self.view.addSubview(quarterLengthSetupLabel)
        self.view.addSubview(quarterLengthSlider)
        quarterLengthSlider.addTarget(self, action: #selector(changeQuarterLengthSetup), for: .valueChanged)
        self.view.addSubview(clockStoppageRangeSetupLabel)
        self.view.addSubview(clockStoppageRangeSlider)
        clockStoppageRangeSlider.addTarget(self, action: #selector(changeClockStoppageRangeSetup), for: .valueChanged)
    }
    
    
    
    @objc
    func changeShortMinutesSetup(){
        shortMinutesWarningLabel.text = "Warning at Minute " + String(describing: Int(shortMinutesSetupSlider.value))
    }
    
    lazy var shortMinutesWarningLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 100, width: self.view.frame.width-100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
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
    
    lazy var quarterLengthSetupLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 250, width: self.view.frame.width - 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Quarter Length: 10"
        return label
    }()
    
    lazy var quarterLengthSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 50, y: 350, width: self.view.frame.width - 100, height: 50))
        slider.maximumValue = 20
        slider.minimumValue = 5
        slider.value = 10
        return slider
    }()
    
    @objc
    func changeQuarterLengthSetup(){
        quarterLengthSetupLabel.text = "Quarter Length: " + String(describing: Int(quarterLengthSlider.value))
    }
    
    
    
    lazy var clockStoppageRangeSetupLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 400, width: self.view.frame.width - 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
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
    
    @objc
    func changeClockStoppageRangeSetup(){
        clockStoppageRangeSetupLabel.text = "Stoppage range: " + String(describing: Int(clockStoppageRangeSlider.value))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
