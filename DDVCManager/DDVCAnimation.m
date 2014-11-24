//
//  DDVCAnimation.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "DDVCAnimation.h"
#import "DDVCManager.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation DDVCAnimationClassic

+(DDVCAnimationClassic *)animation{
    DDVCAnimationClassic *anim = [[DDVCAnimationClassic alloc] init];
    return anim;
    
}

-(CGRect)appFrame{
    return [[DDVCManager sharedManager] appFrame];
}

- (void)pushVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion{

    UIView *preView = topVC.view;
    UIView *curView = curVC.view;
    
    CGRect preRect = [self appFrame];
    preRect.origin.x = - [self appFrame].size.width/3.0f;
    
    CGRect curRect = [self appFrame];
    curRect.origin.x = curRect.size.width;
    curView.frame = curRect;
    [[DDVCManager sharedManager].window addSubview:curView];
    
    [topVC viewWillDisappear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.frame = preRect;
                         curView.frame = [self appFrame];
                         
                     }
                     completion:^(BOOL finished) {
                         [topVC viewDidDisappear:YES];
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                         completion(finished);
                     }];
    
}

- (void)popVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion{

    UIView *preView = preVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = curView.frame;
    curRect.origin.x = curRect.size.width;

    [preVC viewWillAppear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.frame = [self appFrame];
                         curView.frame = curRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [curView removeFromSuperview];
                         [preVC viewDidAppear:YES];
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                         completion(finished);
                     }];
}

- (void)presentVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion{

    UIView *preView = topVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = [self appFrame];
    curRect.origin.y = curRect.size.height;
    curView.frame = curRect;
    
    [[DDVCManager sharedManager].window addSubview:curView];
    
    [topVC viewWillDisappear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.frame = [self appFrame];
                         curView.frame = [self appFrame];
                         
                     }
                     completion:^(BOOL finished) {
                         [topVC viewDidDisappear:YES];
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         completion(finished);
                     }];
    
}

- (void)dismissVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion{

    UIView *preView = preVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = [self appFrame];
    curRect.origin.y = curRect.size.height;
    
    [preVC viewWillAppear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.frame = [self appFrame];
                         curView.frame = curRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [curView removeFromSuperview];
                         [preVC viewDidAppear:YES];

                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         completion(finished);
                     }];
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation DDVCAnimationDepth

+(DDVCAnimationDepth *)animation{
    DDVCAnimationDepth *anim = [[DDVCAnimationDepth alloc] init];
    return anim;
    
}

-(CGRect)appFrame{
    return [[DDVCManager sharedManager] appFrame];
}

- (void)pushVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion{
    
    UIView *preView = topVC.view;
    UIView *curView = curVC.view;

    CGRect curRect = [self appFrame];
    curRect.origin.x = curRect.size.width;
    curView.frame = curRect;
    [[DDVCManager sharedManager].window addSubview:curView];
    
    [topVC viewWillDisappear:YES];

    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{

                         preView.transform = CGAffineTransformMakeScale(0.9,0.9);
                         curView.frame = [self appFrame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [topVC viewDidDisappear:YES];

                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                         completion(finished);
                     }];
    
}

- (void)popVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion{
    
    UIView *preView = preVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = curView.frame;
    curRect.origin.x = curRect.size.width;

    [preVC viewWillAppear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.transform = CGAffineTransformIdentity;
                         curView.frame = curRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [curView removeFromSuperview];
                         [preVC viewDidAppear:YES];

                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         completion(finished);
                         
                     }];
    
}

- (void)presentVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion{
    
    UIView *preView = topVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = [self appFrame];
    curRect.origin.y = curRect.size.height;
    curView.frame = curRect;
    
    [[DDVCManager sharedManager].window addSubview:curView];
    
    [topVC viewWillDisappear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.frame = [self appFrame];
                         preView.transform = CGAffineTransformMakeScale(0.9,0.9);
                         
                         curView.frame = [self appFrame];
                     }
                     completion:^(BOOL finished) {

                         [topVC viewDidDisappear:YES];
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         completion(finished);
                     }];
    
}

- (void)dismissVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion{
    
    UIView *preView = preVC.view;
    UIView *curView = curVC.view;
    
    CGRect curRect = [self appFrame];
    curRect.origin.y = curRect.size.height;
    

    [preVC viewWillAppear:YES];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         preView.transform = CGAffineTransformIdentity;
                         preView.frame = [self appFrame];
                         
                         curView.frame = curRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [curView removeFromSuperview];
                         [preVC viewDidAppear:YES];
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         completion(finished);
                     }];
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
