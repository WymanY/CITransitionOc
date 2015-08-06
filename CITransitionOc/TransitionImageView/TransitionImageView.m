//
//  TransitionImageView.m
//  CITransitionOc
//
//  Created by 武蕴 on 15/8/3.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "TransitionImageView.h"

@interface TransitionImageView ()

@property (nonatomic,strong) CIContext *context;

@end

@implementation TransitionImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 2.0;
        _filter = [CIFilter filterWithName:@"CICopyMachineTransition"];
        _transitionStartTime = 0.0;
        
    }
    return self;
}

- (void)awakeFromNib
{
    _duration = 3.0;
    _filter = [CIFilter filterWithName:@"CICopyMachineTransition"];
    _transitionStartTime = 0.0;
}

- (CIContext *)context
{
    if (nil == _context) {
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
}


- (void)transitionToImage:(UIImage *)toImage
{
    //Check the origin and target image
    if (nil == toImage || nil == self.image) {
        NSAssert(nil != self.image,@"原图为空");
    }
    
    //Set Extent And Color
    CIVector *extent = [CIVector vectorWithX:0.0 Y:0.0 Z:self.image.size.width * 2 W:self.image.size.height * 2 ];
    CIColor *color = [CIColor colorWithRed:0.6 green:1.0 blue:1.0];
    [_filter setValue:extent forKey:kCIInputExtentKey];
    [_filter setValue:color forKey:kCIInputColorKey];
    //SetFilter Parameters
    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
    [_filter setValue:inputImage forKey:kCIInputImageKey];
    
    CIImage *inputTargetImage = [CIImage imageWithCGImage:toImage.CGImage];
    [_filter setValue:inputTargetImage forKey:kCIInputTargetImageKey];
    

    //If a transitionTimer already exisit invalidate it when transition in progress
    if (_transitionTimer.valid) {
        [_transitionTimer invalidate];
    }
    _transitionStartTime = CACurrentMediaTime();
    
    self.transitionTimer = [NSTimer timerWithTimeInterval:1.0/30 target:self selector:@selector(timerFired:) userInfo:toImage repeats:YES];
    [_transitionTimer fire];
    
    [[NSRunLoop mainRunLoop] addTimer:self.transitionTimer forMode:NSDefaultRunLoopMode];
    
}

- (void)timerFired:(NSTimer *)timer
{
    CGFloat time = CACurrentMediaTime();
//    NSLog(@"time = %f,_transitionStartTime = %lf,_duration = %f",time,_transitionStartTime,_duration);
    if (time > _transitionStartTime + _duration) {
        self.image = (UIImage *)timer.userInfo;
        [_transitionTimer invalidate];
    }
    else
    {
        
           double progress = (time - _transitionStartTime )/_duration;
//            NSLog(@"progress =%lf",progress);
            [_filter setValue:@(progress) forKey:kCIInputTimeKey];
            CIImage *outPutImage = _filter.outputImage;
        if (outPutImage == nil) {
//            NSLog(@"outPutImage 为空");
        }
//            CGImageRef outPutCGImage = [self.context createCGImage:outPutImage fromRect:self.image.CIImage.extent];
//        CIImage *outPutCiImage = [CIImage imageWithCGImage:outPutCGImage];
        UIImage *image = [UIImage imageWithCIImage:outPutImage];
        
        self.image = image;

    }
    

   //    CIImage *outPutImage = _filter.outputImage;
//    self.image = [UIImage imageWithCIImage:outPutImage. scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    long progress = (CACurrentMediaTime() - _transitionStartTime )/_duration;
//    [_filter setValue:@(progress) forKey:kCIInputTimeKey];
    
//    CGImageRef outPutCGImage = [self.context createCGImage:_filter.outputImage fromRect:self.image.CIImage.extent];
//    UIImage *outPutImage = [UIImage imageWithCGImage:outPutCGImage];
//    self.image = outPutImage;
    
//    [[UIImage imageWithCIImage:_filter.outputImage] drawInRect:rect];
    
//    CGRect innerBounds = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10);
    
    // To display the image, convert it back to a UIImage and draw it in our rect.  UIImage takes
    // into account the orientation of an image when drawing which we would have needed to worry about
    // when drawing it directly with Core Image and Core Graphics calls.
//    [[UIImage imageWithCIImage:_filteredImage] drawInRect:innerBounds];

}

@end
