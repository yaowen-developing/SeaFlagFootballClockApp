//
//  ClockViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/15/23.
//

import UIKit

class ClockBoardViewController: UIViewController {


    
    convenience init(){
        self.init(game: nil)
    }
    
    init(game: Game?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(gameClockLabel)
        self.view.addSubview(playClockLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(startPause))
        tap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }
    

    
    @objc
    func startPause(){

    }
    
    
    lazy var gameClockLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var playClockLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 300, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
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
