# SlidingNumberView

[![CI Status](https://img.shields.io/travis/bupstan/SlidingNumberView.svg?style=flat)](https://travis-ci.org/bupstan/SlidingNumberView)
[![Version](https://img.shields.io/cocoapods/v/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![License](https://img.shields.io/cocoapods/l/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![Platform](https://img.shields.io/cocoapods/p/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)

## How it looks
![](name-of-giphy.gif)

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
**Swift Version** - 5.0

## Installation

SlidingNumberView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SlidingNumberView'
```

## Usage
- Import SlidingNumberView in the class you want to use.

```
import SlidingNumberView
```

- Initialize a SlidingNumberView object with a starting number and a final number as **String** parameters. (Numbers, as of now, are only supported up to 11 Digits)

```
var numberView = SlidingNumberView(startNumber: "1234", endNumber: "5678")
```
- Call the object's `startCounting` method to start animation.

```
numberView.startCounting(completion: {finish in
	print("Counting Done")
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
