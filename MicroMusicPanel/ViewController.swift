//
//  ViewController.swift
//  MicroMusicPanel
//
//  Created by ChardLl on 2018/6/12.
//  Copyright © 2018年 com.chard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = "MicroMusicPanel"
        
        setupView()
    }
    
    let playButton: UIButton = {
        let bt = UIButton (type: .system)
        bt.setTitle("Pick Me!", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()

    func setupView() {
        view.addSubview(playButton)
        
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        playButton.addTarget(self, action: #selector(showMusicView), for: .touchUpInside)
    }
    
    @objc func showMusicView() {
        print("...")
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarViewController
        tabBarController?.showMusicView()
    }
}

