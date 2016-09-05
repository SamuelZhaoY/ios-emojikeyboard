# iOS-EmojiKeyBoard

[![CI Status](http://img.shields.io/travis/SamuelZhaoY/iOS-EmojiKeyBoard.svg?style=flat)](https://travis-ci.org/SamuelZhaoY/iOS-EmojiKeyBoard)
[![Version](https://img.shields.io/cocoapods/v/Toast.svg?style=flat)](http://cocoapods.org/pods/GZToast)
[![License](https://img.shields.io/cocoapods/l/Toast.svg?style=flat)](http://cocoapods.org/pods/GZToast)
[![Platform](https://img.shields.io/cocoapods/p/Toast.svg?style=flat)](http://cocoapods.org/pods/GZToast)

## Feature List
* Customizable emoji pack & sticker package
* Support .gif animation
* Support long press zoom in effect.
* Support vertical and horizontal screen.
* Handy way of initialization & dismiss.

![emojikeyboarddemo](https://cloud.githubusercontent.com/assets/8198256/18235964/be9ad7c0-7353-11e6-9e33-50aaac5bdaba.gif)

## Example

* Setup: To run the example project, clone the repo, and run `pod install` from the Example directory first.

* Display the keyboard:
```objc
GZStickerPanelControl* emoControl = [GZStickerPanelControl new];
// Bind the input
emoControl.associatedInput = self.emojiInput;
// Show emojiKeyboard
[emoControl addToView:self.view];
```

* Remove the keyboard:
```objc
[emoControl dismiss];
```


## Requirements

The internal auto-layout of the emoji keyboard widget depends on iOS Masonry AutoLayout Tool

## Installation

iOS-EmojiKeyBoard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "iOS-EmojiKeyBoard"
```

## Author

zy.zhao, zhaoy.samuel@gmail.com

## License

iOS-EmojiKeyBoard is available under the MIT license. See the LICENSE file for more info.
