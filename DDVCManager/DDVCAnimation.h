//
//  DDVCAnimation.h
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol DDVCAnimation <NSObject>

@optional
- (void)pushVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion;
- (void)popVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion;

- (void)presentVC:(UIViewController *)curVC topVC:(UIViewController *)topVC completion:(void (^)(BOOL finished))completion;
- (void)dismissVC:(UIViewController *)curVC preVC:(UIViewController *)preVC completion:(void (^)(BOOL finished))completion;

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface DDVCAnimationClassic : NSObject<DDVCAnimation>

+(DDVCAnimationClassic *)animation;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface DDVCAnimationDepth : NSObject<DDVCAnimation>

+(DDVCAnimationDepth *)animation;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////