//
//  SlidingNumberView.swift
//  SlidingNumberView
//
//  Created by Ye Wai Yan on 8/8/19.
//  Copyright © 2019 Ye Wai Yan. All rights reserved.
//

import UIKit

public class SlidingNumberView: UIView {
    
    var fromNumber: String!
    var toNumber: String!
    
    var counterFont: UIFont!
    private var labelStrips: [SlidingNumberStrips]!
    var animationDuration: Double = 2.0
    
    /// These values are used to simulate realistic scrolling effect on numbers
    private var displacementValues = [[0],
                              [0, 0],                                       // 2 Digit Case
                              [0, 0, 10],                                   // 3 Digit Case
                              [0, 0, 0, 10],                                // 4 Digit Case
                              [0, 0, 0, 10, 10],                            // 5 Digit Case
                              [0, 0, 0, 10, 10, 20],                        // 6 Digit Case
                              [0, 0, 0, 10, 10, 20, 20],                    // 7 Digit Case
                              [0, 0, 0, 10, 10, 20, 20 ,30],                // 8 Digit Case
                              [0, 0, 0, 10, 10, 20, 20, 30, 30],            // 9 Digit Case
                              [0, 0, 0, 10, 10, 20, 20, 30, 30, 40],        // 10 Digit Case
                              [0, 0, 0, 10, 10, 20, 20, 30, 30, 40, 40]]    // 11 Digit Case
    
    public init(startNumber: String,
         endNumber: String,
         font: UIFont? = UIFont.systemFont(ofSize: 36)) {
        let digitCount = endNumber.count

        super.init(frame: CGRect(x: 0, y: 0, width: font!.pointSize * CGFloat(digitCount), height: font!.pointSize))

        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.fromNumber = startNumber
        self.toNumber = endNumber
        self.counterFont = font
        
        initializeStackViews()
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        self.layoutIfNeeded()
    }
    
    func initializeStackViews() {
        let digitCount = toNumber.count
        
        var fromChar = [Character]()
        var toChar = [Character]()
        
        for char in fromNumber {
            fromChar.append(char)
        }
        for char in toNumber {
            toChar.append(char)
        }
        
        labelStrips = [SlidingNumberStrips]()
        
        var index = 0
        for char in fromNumber {
            let charCount: CGFloat
            
            if displacementValues[digitCount-1][index] == 0 {
                charCount = CGFloat(abs(fromChar[index].wholeNumberValue! - toChar[index].wholeNumberValue!)) + 1
            } else {
                charCount = CGFloat(abs(fromChar[index].wholeNumberValue! - toChar[index].wholeNumberValue!)) + CGFloat(displacementValues[digitCount-1][index]) + 1
            }
            
            let labelStackView = SlidingNumberStrips(frame: .zero)
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            labelStackView.labelFont = counterFont
            labelStackView.displacementValue = Int(charCount)
            if let currentNo = char.wholeNumberValue {
                labelStackView.currentNumber = currentNo
                labelStackView.targetNumber = toChar[index].wholeNumberValue
                labelStackView.generateCounterStrip()
            }
            self.addSubview(labelStackView)
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: counterFont!.pointSize * CGFloat(index)).isActive = true
            
            labelStrips.append(labelStackView)
            index += 1
        }
    }
    
    public func startCounting(completion:@escaping (Bool) -> ()) {
        for index in 0..<labelStrips.count {
            let tempDuration = animationDuration - 0.2 * Double(index)
            UIView.animate(withDuration: tempDuration, delay: 1, options: [], animations: {
                self.labelStrips[index].frame.origin.y -= (self.labelStrips[index].frame.height - self.labelStrips![index].subviews[0].frame.height)
            }, completion: {finish in
                // FIXME:
                completion(true)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
