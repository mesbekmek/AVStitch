//
//  AVVideoViewController.m
//  AVStitch
//
//  Created by Mesfin Bekele Mekonnen on 4/26/16.
//  Copyright © 2016 Mesfin Bekele Mekonnen. All rights reserved.
//

#import "AVVideoViewController.h"

@interface AVVideoViewController ()

@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong, nonatomic) UIButton *cancelButton;
@property (nonatomic) UIView *spinnerView;
@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) UIButton *replay;

@end

@implementation AVVideoViewController


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self performSetUpForAVPlayer];
    [self cancelButton];
}

#pragma mark - UI Setup Methods

- (void)setUpActivityIndicator {
    self.spinnerView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center= self.spinnerView.center;
    activityIndicator.color = [UIColor blackColor];
    self.spinnerView.backgroundColor = [UIColor whiteColor];
    self.spinnerView.alpha = 0.6;
    
    [activityIndicator startAnimating];
    [self.spinnerView addSubview:activityIndicator];
    [self.view addSubview:self.spinnerView];
    [self.view bringSubviewToFront:self.spinnerView];
    
}

- (void)setUpReplayButton {
    
    self.replay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.replay addTarget:self action:@selector(replayVideo:) forControlEvents:UIControlEventAllTouchEvents];
    self.replay.center = self.view.center;
    [self.replay setBackgroundImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
    [self.view addSubview:self.replay];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIButton *)cancelButton {
    if(!_cancelButton) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tintColor = [UIColor whiteColor];
        button.titleLabel.text = @"X";
        button.titleLabel.textColor = [UIColor whiteColor];
        button.imageView.clipsToBounds = NO;
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.4f;
        button.layer.shadowRadius = 1.0f;
        button.clipsToBounds = NO;
        
        _cancelButton = button;
    }
    return _cancelButton;
}

#pragma mark - Private methods

- (void)performFailureAlert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Could not load video. Check connection and try again later" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)cancelButtonPressed:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissSpinnerView{
    
    if (self.spinnerView) {
        [self.spinnerView removeFromSuperview];
    }
    
}

- (void)replayVideo:(UIButton *)replayButton{
    
    self.replay.hidden = YES;
    self.isPlaying = NO;
    [self.playerItem seekToTime:kCMTimeZero];
    
}

- (void)performSetUpForAVPlayer{
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResize;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avPlayer currentItem]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.avPlayerLayer.frame = CGRectMake(0,
                                          0, screenRect.size.width, screenRect.size.height);
    [self.view.layer addSublayer:self.avPlayerLayer];
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.cancelButton];
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.cancelButton.frame = CGRectMake(0, 20, 35, 35);
    
    [self.avPlayer play];
    self.isPlaying = YES;
}

#pragma mark - Player Item Notification Method

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    self.isPlaying = NO;
    
    if (!self.replay) {
        [self setUpReplayButton];
    }
    self.replay.hidden = NO;
    self.playerItem = [notification object];
}

@end
