//
//  ViewController.m
//  KSYVRPlayerDemo
//
//  Created by mayudong on 16/7/20.
//  Copyright © 2016年 mayudong. All rights reserved.
//

#import "ViewController.h"
#import "VRPlayerViewController.h"

@interface ViewController (){
    UIButton* btnLocal;
    UIButton* btnURL;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}

- (void)initUI{
    btnLocal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLocal setTitle:@"播放本地文件" forState: UIControlStateNormal];
    btnLocal.backgroundColor = [UIColor lightGrayColor];
    [btnLocal addTarget:self action:@selector(onPlayLocal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLocal];
    
    btnURL = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnURL setTitle:@"播放网络URL" forState: UIControlStateNormal];
    btnURL.backgroundColor = [UIColor lightGrayColor];
    [btnURL addTarget:self action:@selector(onPlayURL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnURL];
    
    [self layoutUI];
}

- (BOOL)shouldAutorotate {
    [self layoutUI];
    return YES;
}

- (void) layoutUI {
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    CGFloat left = width/4;
    CGFloat btnWidth = width/2;
    CGFloat btnHeight = 40;
    
    CGFloat top1 = (height/2) - btnHeight - 10;
    CGFloat top2 = (height/2) + 10;
    btnLocal.frame = CGRectMake(left, top1, btnWidth, btnHeight);
    btnURL.frame = CGRectMake(left, top2, btnWidth, btnHeight);
    
}

- (void) onPlayLocal {
    NSLog(@"play local file");
    NSString* path = [[NSBundle mainBundle]pathForResource:@"skyrim" ofType:@"mp4"];
    NSURL* url = [NSURL URLWithString:path];
    if(url == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"文件不存在"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    VRPlayerViewController* vc = [[VRPlayerViewController alloc]initWithURL:url];
//    VRPlayerViewController* vc = [[VRPlayerViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void) onPlayURL {
    NSLog(@"play URL");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Play Online URL"
                                                                   message:@"Enter the URL"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Play" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [[NSURL alloc] initWithString:[[alert textFields] firstObject].text];
        VRPlayerViewController* vc = [[VRPlayerViewController alloc]initWithURL:url];
        [self presentViewController:vc animated:NO completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = @"http://kss.ksyun.com/cxy/skyrim.mp4";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
