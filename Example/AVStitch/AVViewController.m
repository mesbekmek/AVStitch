//
//  AVViewController.m
//  AVStitch
//
//  Created by Mesfin Bekele Mekonnen on 04/26/2016.
//  Copyright (c) 2016 Mesfin Bekele Mekonnen. All rights reserved.
//

#import "AVViewController.h"
#import "AVExportHandler.h"
#import "AVVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

const float kVideoLengthMax2 = 10.0;


@interface AVViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic) UIImagePickerController *imagePicker;

@property (nonatomic) NSMutableArray<AVAsset *> *videoAssetsArray;

@property (nonatomic) AVPlayer *avPlayer;

@property (nonatomic) AVPlayerItem *avPlayerItem;

@property (nonatomic) AVPlayerLayer *avPlayerLayer;

@property (weak, nonatomic) IBOutlet UIButton *mergeButton;

@end


@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoAssetsArray = [NSMutableArray new];
    self.mergeButton.enabled = NO;

}

#pragma mark - Image Picker View Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self.videoAssetsArray addObject:[AVAsset assetWithURL:info[UIImagePickerControllerMediaURL]]];
    
    self.mergeButton.enabled = self.videoAssetsArray.count > 1;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self showSuccessAlert];
}


#pragma mark - IBAction methods

- (IBAction)recordButtonTapped:(UIButton *)sender {
    [self setupCamera];
}

- (IBAction)mergeButtonTapped:(UIButton *)sender {
    [self mergeVideosInArray:self.videoAssetsArray];
}

# pragma mark - Video camera setup

- (void)setupCamera{
    
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    self.imagePicker.videoMaximumDuration = kVideoLengthMax2;
    self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;

    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

#pragma mark - Alert

- (void)showSuccessAlert {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Success" message:[NSString stringWithFormat:@"Successfully added video file. Current count of videos is:- %d",self.videoAssetsArray.count] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Merge

- (void)mergeVideosInArray:(NSMutableArray<AVAsset *>*)videosAssestsArray {
    
    [self.avPlayerLayer removeFromSuperlayer];
    self.avPlayerLayer =nil;
    self.avPlayerItem = nil;
    self.avPlayer = nil;
    
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


@end
