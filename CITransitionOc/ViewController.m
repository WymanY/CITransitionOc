//
//  ViewController.m
//  CITransitionOc
//
//  Created by 武蕴 on 15/8/2.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "ViewController.h"
#import "TransitionImageView.h"
#import "UIView+BlockGesture.h"

@interface ViewController ()
{
    NSString *currentImageName;
}
@property (weak, nonatomic) IBOutlet TransitionImageView *transitionImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [_transitionImageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        currentImageName = ([currentImageName  isEqualToString:@"Photo2.jpg"]) ? @"Photo1.jpg" : @"Photo2.jpg";
        [_transitionImageView transitionToImage:[UIImage imageNamed:currentImageName]];
//        imageView.transitionToImage(UIImage(named: currentImageName)) 
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
