//
//  ViewController.swift
//  SwipeGestureRecognizerTut
//
//  Created by Sukumar Anup Sukumaran on 18/10/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var viewSwipe: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var swipeGesture  = UISwipeGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        addingSwipeGestures()
    }
    
    //MARK: adding Swipe gestures to viewSwipe
    func addingSwipeGestures() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
            viewSwipe.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            viewSwipe.isUserInteractionEnabled = true
            viewSwipe.isMultipleTouchEnabled = true
        }
    }
    
    //MARK: add swipe gesture action
    @objc
    func swipeView(_ sender : UISwipeGestureRecognizer){
        
        UIView.animate(withDuration: 1.0) {
            if sender.direction == .right {
                self.rightSwipeAction()
            } else if sender.direction == .left {
                self.leftSwipeAction()
            } else if sender.direction == .up {
                self.upSwipeAction()
            } else if sender.direction == .down {
                self.downSwipeAction()
            }
            
            self.viewSwipe.layoutIfNeeded()
            self.viewSwipe.setNeedsDisplay()
        }
        
    }
    
    //MARK: func for anction right
    func rightSwipeAction() {
        self.viewSwipe.frame = CGRect(x: self.view.frame.size.width - self.viewSwipe.frame.size.width, y: self.viewSwipe.frame.origin.y , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)
    }
    
    //MARK: func for anction left
    func leftSwipeAction() {
        self.viewSwipe.frame = CGRect(x: 0, y: self.viewSwipe.frame.origin.y , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)

    }
    
    //MARK: func for anction up
    func upSwipeAction() {
        self.viewSwipe.frame = CGRect(x: self.view.frame.size.width - self.viewSwipe.frame.size.width, y: 0 , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)
    }
    
    //MARK: func for anction down
    func downSwipeAction() {
        self.viewSwipe.frame = CGRect(x: self.view.frame.size.width - self.viewSwipe.frame.size.width, y: self.view.frame.size.height - self.viewSwipe.frame.height , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)
    }


}

