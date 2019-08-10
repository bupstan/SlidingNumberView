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
    
    var numberView: SlidingNumberView!

    @IBAction func clickOnStartCounting(_ sender: Any) {
        if let _ = numberView {
            numberView.removeFromSuperview()
        }
        numberView = SlidingNumberView(startNumber: "0100", endNumber: "1250")
        view.addSubview(self.numberView)
        
        numberView.translatesAutoresizingMaskIntoConstraints = false
        numberView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        view.layoutIfNeeded()
        
        numberView.startCounting(completion: {finish in
            self.numberView.endNumber = "0000"
            self.numberView.startCounting(completion: {finish in
                print("Counting Finally Done")
            })
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

