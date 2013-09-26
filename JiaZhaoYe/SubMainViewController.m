//
//  SubMainViewController.m
//  JiaZhaoYe
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SubMainViewController.h"
#import "QiYeViewController.h"
#import "XiangMuViewController.h"

@interface SubMainViewController ()

@end

@implementation SubMainViewController
@synthesize containerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayContentController: (UIViewController*) content;
{
    /*
    [self addChildViewController:content];                 // 1
    content.view.frame = [self frameForContentController]; // 2
    [self.view addSubview:self.currentClientView];
    [content didMoveToParentViewController:self];          // 3
     */
}


- (void) hideContentController: (UIViewController*) content
{
    /*
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
     */
}

- (void) cycleFromViewController: (UIViewController*) oldC
                toViewController: (UIViewController*) newC
{
    [oldC willMoveToParentViewController:nil];                        // 1
    [self addChildViewController:newC];
    
    newC.view.frame = containerView.frame;                       // 2
    CGRect endFrame = containerView.frame;
    
    [self transitionFromViewController: oldC toViewController: newC   // 3
                              duration: 1 options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                newC.view.frame = containerView.frame;                       // 4
                                oldC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                [oldC removeFromParentViewController];                   // 5
                                [newC didMoveToParentViewController:self];
                            }];
}


- (IBAction)btQiYeJianJie:(UIButton *)sender {
    NSUInteger nCount = [self.childViewControllers count];
    assert(nCount == 1);
    if ([[self.childViewControllers[0] restorationIdentifier] isEqual: @"QiYe"]) {
        return;
    }
    
    QiYeViewController *QiYeController = [self.storyboard instantiateViewControllerWithIdentifier:@"QiYe"];
    
    
    [self cycleFromViewController:self.childViewControllers[0] toViewController:QiYeController];
}

- (IBAction)btXiangMuGaiShu:(UIButton *)sender {
    NSUInteger nCount = [self.childViewControllers count];
    assert(nCount == 1);
    if ([[self.childViewControllers[0] restorationIdentifier] isEqual: @"XiangMu"]) {
        return;
    }
    
    XiangMuViewController *XiangMuController = [self.storyboard instantiateViewControllerWithIdentifier:@"XiangMu"];
    
    
    [self cycleFromViewController:self.childViewControllers[0] toViewController:XiangMuController];
}
@end
