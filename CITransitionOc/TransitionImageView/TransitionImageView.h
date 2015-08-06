//
//  TransitionImageView.h
//  CITransitionOc
//
//  Created by 武蕴 on 15/8/3.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface TransitionImageView : UIImageView

@property (nonatomic,assign) IBInspectable double         duration;

@property (nonatomic,strong) CIFilter       *filter;

@property (nonatomic,assign) CFTimeInterval transitionStartTime;

@property (nonatomic,strong) NSTimer        *transitionTimer;

- (void)transitionToImage:(UIImage *)toImage;

@end
