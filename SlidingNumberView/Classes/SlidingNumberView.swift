//
//  SlidingNumberView.swift
//  SlidingNumberView
//
//  Created by Ye Wai Yan on 8/8/19.
//  Copyright © 2019 Ye Wai Yan. All rights reserved.
//

import UIKit

/// Sliding Acceleration Direction
public enum SlidingAcceleration {
    
    /// leftToRight means Right-most digit will slide the fastest
    case leftToRight
    
    /// rightToLeft means Left-most digit will slide the fastest
    case rightToLeft
}

public class SlidingNumberView: UIView {
    
    private var fromNumber: String! = "0000"
    private var toNumber: String! = "0000"
    private var counterFont: UIFont!
    
    private var isShrinking: Bool = false
    private var shrinkingTarget: Int = 0

    private var counting: Bool = false
    public var inProgress: Bool {
        return counting
    }

    /// The start number of the sliding animation. MUST be in String with the same digits as the endNumber
    public var startNumber: String! {
        didSet {
            self.fromNumber = startNumber
            if fromNumber.count != toNumber.count {
                if (fromNumber.count > toNumber.count) {
                    var zeroString = ""
                    for _ in 0..<abs(fromNumber.count - toNumber.count) {
                        zeroString += "0"
                    }
                    toNumber += zeroString
                } else {
                    toNumber = String(toNumber.prefix(fromNumber.count))
                }
            }
            cleanAndSetup()
        }
    }
    
    /// The end number of the sliding animation. MUST be in String with the same digits as the startNumber
    public var endNumber: String! {
        didSet {
            self.toNumber = endNumber
            if toNumber.count != fromNumber.count {
                if (toNumber.count > fromNumber.count) {
                    var zeroString = ""
                    for _ in 0..<abs(fromNumber.count - toNumber.count) {
                        zeroString += "0"
                    }
                    fromNumber += zeroString
                } else {
                    isShrinking = true
                    shrinkingTarget = toNumber.count
                }
            }
            cleanAndSetup()
        }
    }
    
    /// The font used to initialize the labels for counting. (It currently supports system font of any size)
    public var font: UIFont! {
        didSet {
            self.counterFont = font
            cleanAndSetup()
            self.layoutIfNeeded()
        }
    }
    
    /// The spacing points between digits. Default is 0.
    public var digitSpacing: CGFloat = 0 {
        didSet {
            cleanAndSetup()
            self.layoutIfNeeded()
        }
    }
    
    /// The direction in which the left-most or right-most digit will slide the fastest
    public var accelerationDirection: SlidingAcceleration = .leftToRight {
        didSet {
            cleanAndSetup()
        }
    }
    
    /// The total duration of the animation that will slide for the counting animation
    public var animationDuration: Double = 3
    
    private var slideUp: Bool! = true {
        didSet {
            updateSlideDirection()
        }
    }
    
    private func cleanAndSetup() {
        for strip in labelStrips {
            for subview in strip.subviews {
                subview.removeFromSuperview()
            }
            strip.removeFromSuperview()
        }
        initializeStackViews()
    }

    private var labelStrips: [SlidingNumberStrips]!
    private var labelStripsTopConstraints: [NSLayoutConstraint]!
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var widthValue: CGFloat!
    private var heightValue: CGFloat!
    
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
        let digitCount = startNumber.count
        super.init(frame: CGRect(x: 0, y: 0, width: font!.pointSize * CGFloat(digitCount), height: font!.pointSize))
        
        self.layer.masksToBounds = true
        self.fromNumber = startNumber
        self.toNumber = endNumber
        self.counterFont = font
        
        initializeStackViews()
        self.layoutIfNeeded()
    }
    
    private func initializeStackViews() {
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
        labelStripsTopConstraints = [NSLayoutConstraint]()
        
        var index = 0
        for char in fromNumber {
            let charCount: CGFloat
            
            var displacement = [Int]()
            
            if accelerationDirection == .leftToRight {
                displacement = isShrinking ? displacementValues[shrinkingTarget - 1] : displacementValues[digitCount - 1]
            } else if accelerationDirection == .rightToLeft {
                displacement = isShrinking ? displacementValues[shrinkingTarget - 1].reversed() : displacementValues[digitCount - 1].reversed()
            }
//            print(isShrinking)
            
            if displacement[index] == 0 {
                charCount = CGFloat(abs(fromChar[index].wholeNumberValue! - toChar[index].wholeNumberValue!)) + 1
            } else {
                charCount = CGFloat(abs(fromChar[index].wholeNumberValue! - toChar[index].wholeNumberValue!)) + CGFloat(displacement[index]) + 1
            }
            
            let labelStackView = SlidingNumberStrips(frame: .zero)
            labelStackView.labelFont = counterFont
            labelStackView.displacementValue = Int(charCount)
            if let currentNo = char.wholeNumberValue {
                labelStackView.currentNumber = currentNo
                labelStackView.targetNumber = toChar[index].wholeNumberValue
                labelStackView.generateCounterStrip()
            }
            self.addSubview(labelStackView)
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            
            self.layoutIfNeeded()   // have to call this to obtain the height of the label
            let topConstraint = NSLayoutConstraint(item: labelStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            
            labelStackView.labelSize = labelStackView.subviews[0].frame.size
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: "0".widthOfString(usingFont: counterFont) * CGFloat(index) + digitSpacing * CGFloat(index)).isActive = true
            labelStackView.widthAnchor.constraint(equalToConstant: getLargestLabelStripWidth()).isActive = true

            if slideUp {
                topConstraint.constant = 0
            } else {
                let count = labelStackView.subviews.count
                topConstraint.constant = -labelStackView.labelSize!.height * CGFloat(count - 1)
            }
            self.addConstraint(topConstraint)
            
            labelStrips.append(labelStackView)
            labelStripsTopConstraints.append(topConstraint)
            index += 1
        }
        
        var width: CGFloat
        var height:CGFloat
        
        if (labelStrips.count == 1) {
            width = "0".widthOfString(usingFont: counterFont)
            height = getLargestLabelStripHeight()
        } else {
            if isShrinking {
                width = getLargestLabelStripWidth() * CGFloat(shrinkingTarget) + digitSpacing * (CGFloat(shrinkingTarget) - 1)
            } else {
                width = getLargestLabelStripWidth() * CGFloat(digitCount) + digitSpacing * (CGFloat(digitCount) - 1)
            }
            height = getLargestLabelStripHeight()
        }
        
        
        if let _ = widthConstraint, let _ = heightConstraint {
            widthValue = width
            heightValue = height
        } else {
            widthValue = width
            heightValue = height
            widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
            self.addConstraints([widthConstraint, heightConstraint])
        }
    }
    
    private func updateSlideDirection() {
        let tempNum = self.fromNumber
        self.fromNumber = self.toNumber
        self.toNumber = tempNum
        
        cleanAndSetup()
        
        if slideUp {
            for constraint in labelStripsTopConstraints {
                constraint.constant = 0
            }
        } else {
            var index = 0
            for constraint in labelStripsTopConstraints {
                constraint.constant = -labelStrips[index].labelSize.height * CGFloat(labelStrips[index].subviews.count - 1)
                index += 1
            }
        }
    }
    
    /// Starts the counting with sliding animation with a completion handler
    public func startCounting(completion:@escaping (Bool) -> ()) {
        counting = true
        widthConstraint.constant = widthValue
        heightConstraint.constant = heightValue
       
        var finishCount = 0
        for index in 0..<labelStrips.count {
            let tempDuration = animationDuration - 0.2 * Double(index)
            if self.slideUp {
                self.labelStripsTopConstraints[index].constant = -self.labelStrips[index].labelSize.height * CGFloat(self.labelStrips[index].subviews.count - 1)
            } else {
                self.labelStripsTopConstraints[index].constant = 0
            }
            UIView.animate(withDuration: tempDuration, delay: 0, options: [], animations: {
                self.layoutIfNeeded()
            }, completion: {finish in
                finishCount += 1
                if (finishCount == self.labelStrips.count) {
                    self.fromNumber = self.toNumber
                    self.cleanAndSetup()
                    self.layoutIfNeeded()
                    self.counting = false
                    completion(true)
                }
                // FIXME: Optimize stack views and labels here
            })
        }
    }
    
    private func getLargestLabelStripWidth() -> CGFloat {
        return "0".widthOfString(usingFont: counterFont)
    }
    
    private func getLargestLabelStripHeight() -> CGFloat {
        var result:CGFloat = 0
        for view in labelStrips {
            result = view.labelSize.height > result ? view.labelSize.height : result
        }
        return result
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.counterFont = UIFont.systemFont(ofSize: 36)
        initializeStackViews()
        self.layoutIfNeeded()
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
