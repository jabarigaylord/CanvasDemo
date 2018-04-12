//
//  CanvasViewController.swift
//  CanvasDemo
//
//  Created by Jabari on 4/4/18.
//  Copyright © 2018 Jabari. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
   
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var trayDownOffset: CGFloat!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!


    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
        trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.trayView.center = self.trayUp
                })
            }
        }
        
        
        
        
    }
   @objc func didPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            
        }
    }
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
       var imageView = sender.view as! UIImageView
        let translation = sender.translation(in: view)

        
        if sender.state == .began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
            newlyCreatedFace.isUserInteractionEnabled = true
                newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)


            }
        
        
        
    }
    

}
