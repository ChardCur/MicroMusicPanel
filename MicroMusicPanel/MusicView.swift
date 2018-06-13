//
//  MusicView.swift
//  MicroMusicPanel
//
//  Created by ChardLl on 2018/6/12.
//  Copyright © 2018年 com.chard. All rights reserved.
//

import UIKit

class MusicView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var isMiniPanel: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "al")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 5
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let titleView: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    let dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Dismiss", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return btn
    }()
    
    let musicPanel: UIToolbar = {
        let v = UIToolbar()
        return v
    }()
    
    let line: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 0.2)
        return v
    }()
    
    var mainImageTopConstraint: NSLayoutConstraint!
    var mainImageLeftConstraint: NSLayoutConstraint!
    var mainImageWidthConstraint: NSLayoutConstraint!
    var mainImageHeightConstraint: NSLayoutConstraint!
    var mainImageCenterXConstraint: NSLayoutConstraint!
    
    func setupViews() {
        addSubview(dismissBtn)
        addSubview(titleView)
        addSubview(mainImageView)
        insertSubview(musicPanel, belowSubview: mainImageView)
        musicPanel.addSubview(line)
        
        mainImageTopConstraint = mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100)
        mainImageTopConstraint.isActive = true
        mainImageWidthConstraint = mainImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8)
        mainImageWidthConstraint.isActive = true
        mainImageHeightConstraint = mainImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8)
        mainImageHeightConstraint.isActive = true
        mainImageLeftConstraint = mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        mainImageCenterXConstraint = mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        mainImageCenterXConstraint.isActive = true
        
        dismissBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 78, height: 50)
        dismissBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dismissBtn.addTarget(self, action: #selector(handleDidmiss), for: .touchUpInside)
        
        musicPanel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 64)
        
        line.anchor(top: musicPanel.topAnchor, left: musicPanel.leftAnchor, bottom: nil, right: musicPanel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    var panGesture: UIPanGestureRecognizer!
    
    func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//        musicPanel.addGestureRecognizer(panGesture)
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        musicPanel.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarViewController
        tabBarController?.showMusicView()
    }
    
    @objc func handlePanGesture(ges: UIPanGestureRecognizer) {
        if ges.state == .changed {
            handlePanChanged(ges: ges)
        } else if ges.state == .ended {
            handlePanEnded(ges: ges)
        }
    }
    
    func handlePanChanged(ges: UIPanGestureRecognizer) {
        let translation = ges.translation(in: self.superview)
        let height = UIScreen.main.bounds.height
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarViewController
        tabBarController?.maxPanelTopConstraint.isActive = true
        
        if isMiniPanel {
            tabBarController?.maxPanelTopConstraint.constant = height + translation.y - 64 - (tabBarController?.tabBar.frame.size.height)!
            musicPanel.alpha = 1 + translation.y / height
            tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: -45 * (translation.y / height))
            tabBarController?.view.layoutIfNeeded()
        }else {
            tabBarController?.maxPanelTopConstraint.constant = 64 + translation.y
            musicPanel.alpha = translation.y / height
            tabBarController?.view.layoutIfNeeded()
        }
    }
    
    func handlePanEnded(ges: UIPanGestureRecognizer) {
        let translation = ges.translation(in: self.superview)
        let velocity = ges.velocity(in: self.superview)
        print("Ended:", velocity.y)
        
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarViewController
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            if translation.y < -200 || velocity.y < -500 {
                tabBarController?.showMusicView()
            } else {
                tabBarController?.minimizeMusicView()
                self.musicPanel.alpha = 1
            }
        })
    }
    
    @objc func handleDidmiss() {
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarViewController
        tabBarController?.minimizeMusicView()
    }
}
