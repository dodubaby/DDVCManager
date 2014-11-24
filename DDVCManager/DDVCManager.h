//
//  DDVCManager.h
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum _DDAnimType{
    
    DDAnimTypeClassic,
    DDAnimTypeDepth
    
}DDAnimType;

@interface DDVCManager : NSObject
@property (nonatomic,readonly) UIWindow *window;
@property (nonatomic,strong) UIViewController *rootViewController;

+(DDVCManager *)sharedManager;

+(void)setAnimType:(DDAnimType)type;
+(DDAnimType)animType;

-(UIViewController *)topVC;
-(UIViewController *)preVC;

-(CGRect)appFrame;

-(CGFloat)navbarHeight;

-(void)pushVC:(UIViewController *)vc;
-(void)popVC;
-(void)popToVC:(NSString *)vcName;
-(void)popToRootVC;

-(void)presentVC:(UIViewController *)vc;
-(void)dismissVC;

@end
