#
# Be sure to run `pod lib lint SlidingNumberView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SlidingNumberView'
  s.version          = '0.0.3'
  s.summary          = 'SlidingNumberView is a custom view that will count from an initial number to a final number with sliding animation'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'SlidingNumberView enables numbers to change like the hand tally counter (most relevant example). It changes from a starting number to a final number with sliding animation. Currently, it supports numbers up to 11 Digits'

  s.homepage         = 'https://github.com/bupstan/SlidingNumberView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bupstan' => 'bupstan.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/bupstan/SlidingNumberView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'SlidingNumberView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SlidingNumberView' => ['SlidingNumberView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
