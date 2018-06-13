//
//  TabBarViewController.swift
//  MicroMusicPanel
//
//  Created by ChardLl on 2018/6/12.
//  Copyright © 2018年 com.chard. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBarItem()
        
        setupMusicView()
    }
    
    let musicView: MusicView = MusicView()
    var maxPanelTopConstraint: NSLayoutConstraint!
    var miniPanelTopConstraint: NSLayoutConstraint!
    var musicViewHeightConstraint: NSLayoutConstraint!
    var musicViewBottomConstraint: NSLayoutConstraint!
    
    func showMusicView() {
        miniPanelTopConstraint.isActive = false
        maxPanelTopConstraint.isActive = true
        maxPanelTopConstraint.constant = 0
        
        setMaxmizeImageAnchor()
        
        musicView.isMiniPanel = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            self.musicView.musicPanel.alpha = 0
        })
    }
    
    func minimizeMusicView() {
        print("panel")
        
        miniPanelTopConstraint.isActive = true
        maxPanelTopConstraint.isActive = false
        maxPanelTopConstraint.constant = view.frame.height
        
        setMinimizeImageAnchor()
        
        musicView.isMiniPanel = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            
            self.tabBar.transform = .identity
            
            self.musicView.musicPanel.alpha = 1
        })
    }
    
    func setMaxmizeImageAnchor() {
        musicView.mainImageTopConstraint.constant = 100
        musicView.mainImageWidthConstraint.constant = UIScreen.main.bounds.width * 0.8
        musicView.mainImageHeightConstraint.constant = UIScreen.main.bounds.width * 0.8
        musicView.mainImageLeftConstraint.isActive = false
        musicView.mainImageCenterXConstraint.isActive = true
    }
    
    func setMinimizeImageAnchor() {
        musicView.mainImageWidthConstraint.constant = 46
        musicView.mainImageHeightConstraint.constant = 46
        musicView.mainImageTopConstraint.constant = 9
        musicView.mainImageLeftConstraint.constant = 20
        musicView.mainImageLeftConstraint.isActive = true
        musicView.mainImageCenterXConstraint.isActive = false
    }
    
    fileprivate func setupMusicView() {
        view.insertSubview(musicView, belowSubview: tabBar)
        musicView.translatesAutoresizingMaskIntoConstraints = false
        
        maxPanelTopConstraint = musicView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maxPanelTopConstraint.isActive = true
        
        miniPanelTopConstraint = musicView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
//        miniPanelTopConstraint.isActive = true
        
        musicViewHeightConstraint = musicView.heightAnchor.constraint(equalToConstant: view.frame.height)
        musicViewHeightConstraint.isActive = true
        
        musicViewBottomConstraint = musicView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        musicViewBottomConstraint.isActive = true
        
        musicView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        musicView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupTabBarItem() {
        let vc = UINavigationController(rootViewController: ViewController())
        vc.tabBarItem.title = "My Heart"
        vc.tabBarItem.image = #imageLiteral(resourceName: "heart")
        viewControllers = [vc];
    }

}
