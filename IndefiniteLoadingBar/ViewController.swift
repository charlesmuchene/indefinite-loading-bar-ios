//
//  ViewController.swift
//  IndefiniteLoadingBar
//
//  Created by Charles Muchene on 17/06/2017.
//  Copyright © 2017 SenseiDevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bar: IndefiniteLoadingBar!
    
    override func viewDidLoad() {
        bar.loopDelay = 0.1
        bar.animationDuration = 1.2
        bar.progressColor = UIColor.brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bar.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        bar.stopAnimating()
    }
}

