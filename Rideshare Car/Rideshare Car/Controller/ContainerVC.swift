//
//  ContainerVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 12/6/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: Enum's and global variable

enum SlideOutState {
    case collapsed
    case leftMenuExpanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {

    // MARK: Class variable
    
    var homeVC: HomeVC!
    var leftVC: LeftSideMenuVC!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = (currentState != .collapsed)
            
            shouldShowShadowForCenterVC(status: shouldShowShadow)
        }
    }
    var centerController: UIViewController!
    
    var isHidden = false
    let centerMenuExpandedOffSet: CGFloat = 160
    
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCenter(screen: showVC)
    }
    
    func setCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        
        if let controller = centerController {
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
}

// MARK: Extension

extension ContainerVC: CenterDelegate {
   
    func toggleLeft() {
        let notAlreadyExpanded = (currentState != .leftMenuExpanded)
        
        if notAlreadyExpanded {
            addLeftVC()
        }
        animatedLeftMenu(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftVC() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftVC()
            addChildSideMenuVC(leftVC!)
        }
    }
    
    func addChildSideMenuVC(_ sideMenuController: LeftSideMenuVC) {
        view.insertSubview(sideMenuController.view, at: 0)
        addChild(sideMenuController)
        sideMenuController.didMove(toParent: self)
    }
    
    @objc func animatedLeftMenu(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            
            setupWhiteCoverView()
            
            currentState = .leftMenuExpanded
            
            animateCenterMenuXPosition(targetPosition: centerController.view.frame.width - centerMenuExpandedOffSet)

        } else {
            isHidden = !isHidden
            animateStatusBar()
            
            hideWhiteCoverView()
            
            animateCenterMenuXPosition(targetPosition: 0, completion: { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func setupWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 95
        
        self.centerController.view.addSubview(whiteCoverView)
        whiteCoverView.fadeTo(alphaValeu: 0.60, withDuration: 0.3)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animatedLeftMenu(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView() {
        centerController.view.removeGestureRecognizer(tap)
        
        for subview in self.centerController.view.subviews {
            if subview.tag == 95 {
                UIView.animate(withDuration: 0.3, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func shouldShowShadowForCenterVC(status: Bool) {
        if status == true {
            centerController.view.layer.shadowOpacity = 0.8
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func animateCenterMenuXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
}

// MARK: Private extension

private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftVC() -> LeftSideMenuVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSideMenuVC") as? LeftSideMenuVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
    
}
