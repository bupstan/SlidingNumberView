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
- iOS 12.0
- Swift 5.0

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
            
        })
```


## Known Limitations
- SlidingNumberView is in alpha state.
- SlidingNumberView can only be initialized programmatically like the usage above.
- Only support system font of various sizes with a regular weight only.
- Only numbers of the same digits can be animated
	- (1234 to 4567) ✔️
	- (123 to 4567) ✖️
	- (0123 to 4567) ✔️

## To be implemented
- [ ] Multiple font weights
- [ ] Support for animating through different digit numbers
- [ ] Support for initializing through storyboard objects and IBOutlets

## Author

bupstan, bupstan.dev@gmail.com

## License

SlidingNumberView is available under the MIT license. See the LICENSE file for more info.
