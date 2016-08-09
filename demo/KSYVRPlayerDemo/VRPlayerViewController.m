//
//  VRPlayerViewController.m
//  KSYVRPlayerDemo
//
//  Created by mayudong on 16/7/20.
//  Copyright © 2016年 mayudong. All rights reserved.
//

#import "VRPlayerViewController.h"
#import <KSYVRPlayer/KSYVRPlayerController.h>

@interface VRPlayerViewController (){
    UIButton* btnClose;
    UIButton* btnInteractive;
    UIButton* btnDisplay;
    
    NSInteger curIMode;
    NSInteger curDMode;
    BOOL hideButton;
    NSTimer* timer;
}

@property (nonatomic, strong)NSURL* url;
@property (nonatomic, strong)KSYVRPlayerController* player;

@end

@implementation VRPlayerViewController

- (void)dealloc{
//    [self releaseObservers];
}

- (instancetype)initWithURL:(NSURL *)url {
    if((self = [super init])) {
        self.url = url;        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupObservers];
    [self initPlayer];
    [self initUI];
}

- (void)initUI{
    btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setTitle:@"关闭" forState:UIControlStateNormal];
    [btnClose setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    [btnClose addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
    
    btnInteractive = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnInteractive setTitle:@"iMode" forState:UIControlStateNormal];
    [btnInteractive setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    [btnInteractive addTarget:self action:@selector(onSwitchIMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnInteractive];
    
    btnDisplay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnDisplay setTitle:@"dMode" forState:UIControlStateNormal];
    [btnDisplay setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    [btnDisplay addTarget:self action:@selector(onSwitchDMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDisplay];
    
    [self layoutUI];
    [self updateButtonText];
}

- (void)updateButtonText{
    NSString* dModeStr;
    KSYVRModeDisplay dMode = self.player.dMode;
    if(KSYVRModeDisplayNormal == dMode){
        dModeStr = @"单目";
    }else{
        dModeStr = @"双目";
    }
    
    NSString* iModeStr;
    KSYVRModeInteractive iMode = self.player.iMode;
    if(KSYVRModeInteractiveMotion == iMode){
        iModeStr = @"运动";
    }else if(KSYVRModeInteractiveTouch == iMode){
        iModeStr = @"触摸";
    }else{
        iModeStr = @"运动+触摸";
    }
    
    [btnInteractive setTitle:iModeStr forState:UIControlStateNormal];
    [btnDisplay setTitle:dModeStr forState:UIControlStateNormal];
    curIMode = iMode;
    curDMode = dMode;
}


- (void)initPlayer{
    self.player = [[KSYVRPlayerController alloc] initWithContentURL:self.url];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.player.shouldAutoplay = YES;
    self.player.videoDecoderMode = MPMovieVideoDecoderMode_Hardware;
    self.player.shouldLoop = YES;
    
//    [self.player.view setFrame:self.view.bounds];
//    [self.view addSubview:self.player.view];
    
    [self.player initVRMode:KSYVRModeInteractiveMotion dispalyMode:KSYVRModeDisplayGlass];
    [_player setContainer:self view:self.view];
    
    [self.player prepareToPlay];
    
    NSString* sdkVersion = [self.player getVersion];
    NSString* vrVersion = [self.player getVRVersion];
    NSLog(@"SDKVersion = %@, VRVersion = %@", sdkVersion, vrVersion);
}

- (BOOL)shouldAutorotate {
    [self layoutUI];
    return YES;
}

- (void) layoutUI {
    btnClose.frame = CGRectMake(0, 0, 100, 40);
    btnInteractive.frame = CGRectMake(110, 0, 100, 40);
    btnDisplay.frame = CGRectMake(220, 0, 100, 40);
}


- (void) onClose{
    NSLog(@"onClose");
    
    if(self.player != nil){
        [self.player stop];
        self.player = nil;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) onSwitchIMode{
    curIMode = (curIMode+1)%2;
    [self.player setInteractiveMode:curIMode];
    [self updateButtonText];
}

-(void)onSwitchDMode{
    curDMode = (curDMode+1)%2;
    [self.player setDisplayMode:curDMode];
    [self updateButtonText];
}

-(void)hideUI:(BOOL)isHidden{
    [btnDisplay setHidden:isHidden];
    [btnClose setHidden:isHidden];
    [btnInteractive setHidden:isHidden];
}

-(void)onTimer:(id)sender{
    [self hideUI:YES];
}


- (void)setupObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMediaPlaybackIsPreparedToPlayDidChangeNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerPlaybackStateDidChangeNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerPlaybackDidFinishNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerLoadStateDidChangeNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMovieNaturalSizeAvailableNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerFirstVideoFrameRenderedNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerFirstAudioFrameRenderedNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerSuggestReloadNotification)
                                              object:nil];

}


- (void)releaseObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerLoadStateDidChangeNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMovieNaturalSizeAvailableNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerFirstVideoFrameRenderedNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerFirstAudioFrameRenderedNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerSuggestReloadNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackStatusNotification
                                                 object:nil];
}


-(void)handlePlayerNotify:(NSNotification*)notify
{
    if (MPMediaPlaybackIsPreparedToPlayDidChangeNotification ==  notify.name) {
        NSLog(@"MPMediaPlaybackIsPreparedToPlayDidChangeNotification");
    }
    if (MPMoviePlayerPlaybackStateDidChangeNotification ==  notify.name) {
        NSLog(@"MPMoviePlayerPlaybackStateDidChangeNotification");
    }
    if (MPMoviePlayerLoadStateDidChangeNotification ==  notify.name) {
        NSLog(@"player load state: %ld", (long)_player.loadState);
        if (MPMovieLoadStateStalled & _player.loadState) {
            NSLog(@"player start caching");
        }
        
        if (_player.bufferEmptyCount &&
            (MPMovieLoadStatePlayable & _player.loadState ||
             MPMovieLoadStatePlaythroughOK & _player.loadState)){
                NSLog(@"player finish caching");
                NSString *message = [[NSString alloc]initWithFormat:@"loading occurs, %d - %0.3fs",
                                     (int)_player.bufferEmptyCount,
                                     _player.bufferEmptyDuration];
                [self toast:message];
            }
    }
    if (MPMoviePlayerPlaybackDidFinishNotification ==  notify.name) {
        NSLog(@"player finish state: %ld", (long)_player.playbackState);
        NSLog(@"player download flow size: %f MB", _player.readSize);
        NSLog(@"buffer monitor  result: \n   empty count: %d, lasting: %f seconds",
              (int)_player.bufferEmptyCount,
              _player.bufferEmptyDuration);
        int reason = [[[notify userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
        if (reason ==  MPMovieFinishReasonPlaybackEnded) {
            NSLog(@"player finish");
        }else{
            NSString* str = [NSString stringWithFormat:@"player Error : %@", [[notify userInfo] valueForKey:@"error"]];
            [self showMsg:str];
        }
    }
    if (MPMovieNaturalSizeAvailableNotification ==  notify.name) {
        NSLog(@"MPMovieNaturalSizeAvailableNotification");
    }
    if (MPMoviePlayerFirstVideoFrameRenderedNotification == notify.name){
        NSLog(@"MPMoviePlayerFirstVideoFrameRenderedNotification");
    }
    if (MPMoviePlayerFirstAudioFrameRenderedNotification == notify.name){
        NSLog(@"MPMoviePlayerFirstAudioFrameRenderedNotification");
    }
    if (MPMoviePlayerSuggestReloadNotification == notify.name){
        NSLog(@"MPMoviePlayerSuggestReloadNotification");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) toast:(NSString*)message{
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    double duration = 0.5; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void) showMsg:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
