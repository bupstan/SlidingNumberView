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
    
    @IBAction func clickOnStartCounting(_ sender: Any) {
        if let _ = numberView {
            numberView.removeFromSuperview()
        }
        createSlidingNumberView()
    }
    
    var numberView: SlidingNumberView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createSlidingNumberView() {
        numberView = SlidingNumberView(startNumber: "9991", endNumber: "1123")
        numberView.animationDuration = 3
        
        self.view.addSubview(numberView)
        numberView.translatesAutoresizingMaskIntoConstraints = false
        numberView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.view.layoutIfNeeded()
        
        numberView.startCounting(completion: {finish in
            
        })
    }

}

