//
//  ViewController.m
//  JiaZhaoYe
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "SubMainViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize _imageEnter;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    basicAnimation.duration = 1.0f;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.autoreverses = YES;
    basicAnimation.repeatCount = HUGE_VALF;
    [_imageEnter.layer addAnimation:basicAnimation forKey:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_imageEnter.layer removeAllAnimations];
}

//进入2级主界面
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        CGPoint pt = [touch locationInView:_imageEnter];
        if ([_imageEnter pointInside:pt withEvent:event]) {
            
            SubMainViewController *SecondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubMainView"];
            
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 1.0;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionFade;
            animation.subtype = kCATransitionFromRight;;
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            
            [self.navigationController pushViewController:SecondViewController animated:YES];
             
        }
    }
}

@end
