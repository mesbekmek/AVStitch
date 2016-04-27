#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@protocol AVExportHandlerDelegate <NSObject>

- (void)exportDidFinishWithUrl:(NSURL *)url;

@end

@interface AVExportHandler : NSObject

@property (nonatomic, weak) id <AVExportHandlerDelegate> delegate;

@property (nonatomic) AVMutableComposition *mixComposition;

- (void)exportMixComposition:(AVMutableComposition *)mixComposition completion:(void (^) (NSURL *url, BOOL success))onCompletion;

- (void)mergeVideosFrom:(NSMutableArray <AVAsset *> *)videosArray completion:(void(^)(AVMutableComposition *composition, NSError *error))onCompletion;

- (void)playerItemFromVideosArray:(NSMutableArray <AVAsset *> *)videosArray completion:(void(^)(AVPlayerItem *playerItem, NSError *error))completion;

@end
