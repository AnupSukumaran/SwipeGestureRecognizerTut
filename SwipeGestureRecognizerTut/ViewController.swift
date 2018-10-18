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
    @IBOutlet weak var viewDrag: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var topLayoutConstrain: NSLayoutConstraint!
   
    
    let refreshControl = UIRefreshControl()
    var tableView = UITableView()
    
    var swipeGesture  = UISwipeGestureRecognizer()
    var panGesture  = UIPanGestureRecognizer()
    var viewOldPos: CGRect!
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // addingSwipeGestures()
        addingPanGesture()
        //addingTableWithRefresh()
      //  addingEdgeSwipeGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewOldPos = viewDrag.frame
    
    }
    
    //MARK: adding dummy table with refresh control
    func addingTableWithRefresh() {
        tableView.frame = view.frame
        
        refreshControl.addTarget(self, action: #selector(refreshView(refreshControl:)), for: .valueChanged)
        tableView.addSubview(refreshControl)  // here it is
        
        self.view.addSubview(tableView)
    }
    
    @objc
    func refreshView(refreshControl: UIRefreshControl) {
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.attributedTitle = NSAttributedString(string:"Last updated on" + NSDate().description)
        
        //refreshControl.endRefreshing()
    }
    
    //MARK: swipe from the edge action
    func addingEdgeSwipeGesture() {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .top
        
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began {
            print("Screen edge swiped!")
            activityIndicator.startAnimating()
        }
    }
    
    //MARK: func to add pan gesture
    func addingPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        viewDrag.isUserInteractionEnabled = true
        viewDrag.addGestureRecognizer(panGesture)
    }
    
    //MARK: acction func to pangesture action
    @objc
    func draggedView(_ sender:UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(viewDrag)
         guard sender.view != nil else {return}
        let piece = sender.view!
        let translation = sender.translation(in: piece.superview)
       // print("Translation = \(translation)")
        if sender.state == .began {
            initialCenter = piece.center
        }
        
        let yfromCenter = piece.center.y - view.center.y
        
        if sender.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        } else {
            print("cancels😄")
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
        
//        viewDrag.center = CGPoint(x: viewDrag.center.x + translation.x, y: viewDrag.center.y + translation.y)
//        sender.setTranslation(CGPoint.zero, in: self.view)
//
//        if sender.state == UIGestureRecognizer.State.changed {
//            print("began moving😄")
//        }
////
        if sender.state == UIGestureRecognizer.State.changed {
            
            UIView.animate(withDuration: 2) {
                if yfromCenter > 0 {
                    self.activityIndicator.alpha = 1
                }
                
            }
        }
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            UIView.animate(withDuration: 0.2) {
//                self.viewDrag.frame = self.viewOldPos
                self.activityIndicator.startAnimating()
                piece.center = self.initialCenter
            }
        }
    }
    
    //MARK: adding Swipe gestures
    func addingSwipeGestures() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
            self.view.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            self.view.isUserInteractionEnabled = true
            self.view.isMultipleTouchEnabled = true
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
                //self.downSwipeAction()
            } else if sender.state == .ended{
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
//        self.viewSwipe.frame = CGRect(x: self.view.frame.size.width - self.viewSwipe.frame.size.width, y: 0 , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)
        activityIndicator.stopAnimating()
    }
    
    //MARK: func for anction down
    func downSwipeAction() {
        
        activityIndicator.startAnimating()
       
         //   self.topLayoutConstrain.constant = 150
        
//        self.viewSwipe.frame = CGRect(x: self.view.frame.size.width - self.viewSwipe.frame.size.width, y: self.view.frame.size.height - self.viewSwipe.frame.height , width: self.viewSwipe.frame.size.width, height: self.viewSwipe.frame.size.height)
    }


}

