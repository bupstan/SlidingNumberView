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
    
    @IBOutlet weak var targetValue: UILabel!
    @IBOutlet weak var outletNumberView: SlidingNumberView!
    
    var number = 0
    var numberView: SlidingNumberView!

    @IBAction func clickOnStartCounting(_ sender: Any) {
        if (!outletNumberView.inProgress) {
            outletNumberView.startCounting(completion: {finish in
            })
        }
    }
    
    @IBAction func add(_ sender: Any) {
        number += 1000
        outletNumberView.endNumber = "\(number)"
        targetValue.text = "Target Value - \(number)"

    }
    @IBAction func subtract(_ sender: Any) {
        number -= 1000
        outletNumberView.endNumber = "\(number)"
        targetValue.text = "Target Value - \(number)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outletNumberView.font = .systemFont(ofSize: 42)
        outletNumberView.startNumber = "0"
        outletNumberView.endNumber = "\(number)"
        outletNumberView.digitSpacing = 10
        targetValue.text = "Target Value - \(number)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func getSize(){

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


