#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface AVExportHandler : NSObject

@property (nonatomic) AVMutableComposition *mixComposition;

- (void)exportMixComposition:(AVMutableComposition *)mixComposition completion:(void (^)(NSURL *url, float progress, NSError *error))onCompletion;

- (void)mergeVideosFrom:(NSArray <AVAsset *> *)videosArray completion:(void(^)(AVMutableComposition *composition, NSError *error))onCompletion;

- (void)playerItemFromVideosArray:(NSArray <AVAsset *> *)videosArray completion:(void(^)(AVPlayerItem *playerItem, NSError *error))completion;

@end
