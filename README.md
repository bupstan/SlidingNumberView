# SlidingNumberView

[![CI Status](https://img.shields.io/travis/bupstan/SlidingNumberView.svg?style=flat)](https://travis-ci.org/bupstan/SlidingNumberView)
[![Version](https://img.shields.io/cocoapods/v/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![License](https://img.shields.io/cocoapods/l/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![Platform](https://img.shields.io/cocoapods/p/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)

## How it looks
![](Samples/SlidingNumberView-SampleGif.gif)

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 10.0+
- Swift 4.2+

## Installation

SlidingNumberView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SlidingNumberView'
```

## Usage
- Import SlidingNumberView in the class you want to use.

```swift
import SlidingNumberView
```

- Initialize a SlidingNumberView object with a starting number and a final number as **String** parameters (Numbers, as of now, are only supported up to 11 Digits). You can also specify a custom font. However, custom fonts can cause undesirable clipping.

```swift
var numberView = SlidingNumberView(startNumber: "1234", endNumber: "5678")

\\ or 

var numberView = SlidingNumberView(startNumber: "1234", endNumber: "5678", font: UIFont.systemFont(ofSize: 26))
```

- (Optional) You can specify the total animation duration

```swift
numberView.animationDuration = 3
```

- Add to the container view so constraints can be added

```swift
self.view.addSubview(numberView)
numberView.translatesAutoresizingMaskIntoConstraints = false
```

- **SlidingNumberView** has its own weight and height constraint calculated from your font size. So you only need to give its **x** and **y** position constraints.

```swift
numberView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true

numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
```

- Call the object's `startCounting` method to start animation.

```swift
numberView.startCounting(completion: {finish in
	print("Counting Done")
})
```

- The `startCounting` method has a completion handler so you can change to another `endNumber` through its properties and start the counting again. (It is crucial to note that the `startNumber` and `endNumber` are meant to accept strings of the same digit size).

```swift
numberView.startCounting(completion: {finish in
	self.numberView.endNumber = "0000"
	self.numberView.startCounting(completion: { finish in 
		print("Counting Finally done")
	})
})
```

### Full Code Block

```swift
numberView = SlidingNumberView(startNumber: "0100", endNumber: "1250", font: UIFont.systemFont(ofSize: 26))
numberView.animationDuration = 3
        
self.view.addSubview(numberView)
numberView.translatesAutoresizingMaskIntoConstraints = false

numberView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
self.view.layoutIfNeeded()
        
numberView.startCounting(completion: {finish in
	self.numberView.endNumber = "0000"
	self.numberView.startCounting(completion: { finish in 
		print("Counting Finally done")
	})
})
```

## Accessible Properties
```swift
/// Spacing of the Digits
numberView.digitSpacing = 10

/// Digit Font
numberView.font = .systemFont(ofSize: 42)

/// The whole animation duration
numberView.animationDuration = 3

/// Boolean. Is it still counting?
numberView.inProgress
```

## Known Limitations
- SlidingNumberView is in alpha state.
- ~~SlidingNumberView can only be initialized programmatically like the usage above.~~ (Can now be set as a custom class for `UIView` in storyboard.)
- ~~Only numbers of the same digits can be animated~~ (Increasing-digits will smoothly animate through its change, Decreasing ones are snappy)

## To be implemented
- [x] Multiple font weights
- [x] Support for animating through different digit numbers
- [x] Support for initializing through storyboard objects and IBOutlets

## Author

bupstan, bupstan.dev@gmail.com

## License

SlidingNumberView is available under the MIT license. See the LICENSE file for more info.
