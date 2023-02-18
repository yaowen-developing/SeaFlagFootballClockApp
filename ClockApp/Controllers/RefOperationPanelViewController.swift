//
//  RefOperationPanelViewController.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/17/23.
//

import UIKit

protocol RefOperationExecutor {
    func flag()
    func timeout()
}

class RefOperationPanelViewController: UIViewController {

    var refOperationExecutor: RefOperationExecutor?
    
    convenience init(){
        self.init(refOperationExecutor: nil)
    }
    
    init(refOperationExecutor: RefOperationExecutor?) {
        super.init(nibName: nil, bundle: nil)
        self.refOperationExecutor = refOperationExecutor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(flagButton)
        flagButton.addTarget(self, action: #selector(flag), for: .touchDown)

        self.view.addSubview(timeoutButton)
        timeoutButton.addTarget(self, action: #selector(timeout), for: .touchDown)

    }
    
    @objc
    func flag() {
        refOperationExecutor?.flag()
        self.dismiss(animated: false)
    }
    
    @objc
    func timeout() {
        refOperationExecutor?.timeout()
        self.dismiss(animated: false)
    }
    
    lazy var flagButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("Flag", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var timeoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("Timeout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .darkGray
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
