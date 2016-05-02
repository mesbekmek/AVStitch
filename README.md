# AVStitch

[![CI Status](http://img.shields.io/travis/Mesfin Bekele Mekonnen/AVStitch.svg?style=flat)](https://travis-ci.org/Mesfin Bekele Mekonnen/AVStitch)
[![Version](https://img.shields.io/cocoapods/v/AVStitch.svg?style=flat)](http://cocoapods.org/pods/AVStitch)
[![License](https://img.shields.io/cocoapods/l/AVStitch.svg?style=flat)](http://cocoapods.org/pods/AVStitch)
[![Platform](https://img.shields.io/cocoapods/p/AVStitch.svg?style=flat)](http://cocoapods.org/pods/AVStitch)

## Overview
AVStitch is built using the AVFoundation framework and allows you to easily stitch or merge individual videos.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
ARC
## Installation

AVStitch is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AVStitch"
```
##Documentation

###Implementation
To use AVStitch you just need to import the 'AVExportHandler.h' file into the view controller where you will have AVAssets.
For example if you use a camera, you would use the delegate 'imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info' to store your video asset files in an array. Then when you are ready to merge the collection of videos, you would use the convenience method 'playerItemFromVideosArray: completion:' to merge the videos. This methods returns an 'AVPlayerItem' which you can then use to playback the merged videos.
The example below illustrates how to do this:
```objC
- (void)mergeVideosInArray:(NSArray<AVAsset *>*)videosAssestsArray {

    AVExportHandler *exportHandler = [AVExportHandler new];
    [exportHandler playerItemFromVideosArray:videosAssestsArray completion:^(AVPlayerItem *playerItem, NSError *error) {
        
        if (!error) {
            
            AVPlayerItem * pi = playerItem;
            AVPlayer *player = [AVPlayer playerWithPlayerItem:pi];
            AVVideoViewController *videoVC = [AVVideoViewController new];
            videoVC.avPlayer = player;
            [self presentViewController:videoVC animated:YES completion:nil];

        }
        else {
            NSLog(@"Error - %@",error.localizedDescription);
        }
    }];
}
```
## Author

Mesfin Bekele Mekonnen, mesbekmek@gmail.com

## License

AVStitch is available under the MIT license. See the LICENSE file for more info.
