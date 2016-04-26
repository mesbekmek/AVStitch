//
//  SOExportHandler.h
//  Shoutout
//
//  Created by Varindra Hart on 11/29/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@protocol AVExportHandlerDelegate <NSObject>

- (void)exportDidFinishWithUrl:(NSURL *)url;

@end

@interface AVExportHandler : NSObject

@property (nonatomic, weak) id <AVExportHandlerDelegate> delegate;

@property (nonatomic) AVMutableComposition *mixComposition;

- (void)exportMixComposition:(AVMutableComposition *)mixComposition completion:(void (^) (NSURL *url, BOOL success))onCompletion;

- (AVMutableComposition *)mergeVideosFrom:(NSMutableArray <AVAsset *> *)videosArray;

- (AVPlayerItem *)playerItemFromVideosArray:(NSMutableArray <AVAsset *> *)videosArray;

@end
