//
//  UIViewController+DDVCManager.h
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DDVCManager)

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) BOOL enablePanRight;

-(instancetype)initWithName:(NSString *)name;

-(CGRect)appFrame;

-(CGFloat)navbarHeight;

-(void)pushVC:(UIViewController *)vc;
-(void)popVC;
-(void)popToVC:(NSString *)vcName;
-(void)popToRootVC;

-(void)presentVC:(UIViewController *)vc;
-(void)dismissVC;

@end
