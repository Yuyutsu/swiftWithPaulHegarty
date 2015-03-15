//
//  HappinessViewController.swift
//  Happiness
//
//  Created by amol on 12/03/15.
//  Copyright (c) 2015 amolchavan. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    var happiness: Int = 75 { // 0: very sad, 100: ecstatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            println("happiness \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappiessGestureScale: CFloat = 4
    }
    
    @IBAction func changeHappiess(gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .Ended: fallthrough
        case .Changed:
            let tranlation = gesture.translationInView(faceView)
            let happiessChange = -Int(tranlation.y / CGFloat(Constants.HappiessGestureScale))
            if happiness != 0 {
                happiness += happiessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
