//
//  ViewController.swift
//  PET MART
//
//  Created by Hema Likhitha Adapa on 2/21/24.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!
    {
        didSet{
            LaunchLAV.loopMode = .playOnce
            LaunchLAV.animationSpeed = 1.0
            LaunchLAV.play { [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 1.0,
                    delay: 0.0,
                    options:[.curveEaseInOut]){
                        self?.LaunchLAV.alpha = 0.0
                    }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
}

