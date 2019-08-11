//
//  ViewController.swift
//  SlidingNumberView
//
//  Created by bupstan on 08/08/2019.
//  Copyright (c) 2019 bupstan. All rights reserved.
//

import UIKit
import SlidingNumberView

class ViewController: UIViewController {
    
    @IBOutlet weak var outletNumberView: SlidingNumberView!
    var numberView: SlidingNumberView!

    @IBAction func clickOnStartCounting(_ sender: Any) {
        if let _ = numberView {
            numberView.removeFromSuperview()
        }
        numberView = SlidingNumberView(startNumber: "0100", endNumber: "1250")
        
        numberView.animationDuration = 4
        view.addSubview(self.numberView)
        numberView.translatesAutoresizingMaskIntoConstraints = false
        
        // SlidingNumberView only need to setup its X and Y positions
        // but its width and height is calculated by the fontsize
        
        numberView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
        numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        view.layoutIfNeeded()
        
        numberView.startCounting(completion: {finish in
            if finish {
                self.numberView.endNumber = "500000"
                self.numberView.animationDuration = 3
                self.numberView.startCounting(completion: {finish in
                    
                    self.numberView.endNumber = "523000"
                    self.numberView.startCounting(completion: {finish in

                    })
                })
            }
        })
        
        outletNumberView.startCounting(completion: {finish in })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        outletNumberView.startNumber = "12345"
        outletNumberView.endNumber = "668"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

