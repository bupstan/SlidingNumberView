# SlidingNumberView

[![CI Status](https://img.shields.io/travis/bupstan/SlidingNumberView.svg?style=flat)](https://travis-ci.org/bupstan/SlidingNumberView)
[![Version](https://img.shields.io/cocoapods/v/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![License](https://img.shields.io/cocoapods/l/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)
[![Platform](https://img.shields.io/cocoapods/p/SlidingNumberView.svg?style=flat)](https://cocoapods.org/pods/SlidingNumberView)

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

- Initialize a SlidingNumberView object with a starting number and a final number as **String** parameters.

```
var numberView = SlidingNumberView(startNumber: "1234", endNumber: "5678")
```
- Call the object's `startCounting` method to start animation

```
numberView.startCounting()
```




## Author

bupstan, bupstan.dev@gmail.com

## License

SlidingNumberView is available under the MIT license. See the LICENSE file for more info.
