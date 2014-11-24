//
//  UIViewController+DDVCManager.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "UIViewController+DDVCManager.h"
#import <objc/runtime.h>
#import "DDVCManager.h"

@implementation UIViewController (DDVCManager)

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, "DD_VC_MANAGER_NAME", name, OBJC_ASSOCIATION_RETAIN);
}

-(NSString *)name{
    NSString  *name = objc_getAssociatedObject(self, "DD_VC_MANAGER_NAME");
    return name;
}

-(void)setEnablePanRight:(BOOL)enablePanRight{
    objc_setAssociatedObject(self, "DD_VC_MANAGER_PAN_RIGHT", [NSNumber numberWithBool:enablePanRight], OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)enablePanRight{
    NSNumber *pan = objc_getAssociatedObject(self, "DD_VC_MANAGER_PAN_RIGHT");
    return [pan boolValue];
}

-(instancetype)init{
    return [self initWithName:NSStringFromClass([self class])];
}

-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        
        [self setEnablePanRight:YES];
        
        if (name) {
            self.name = name;
        }else{
            self.name = NSStringFromClass([self class]);
        }
    }
    return self;
}

-(CGRect)appFrame{
    return [[DDVCManager sharedManager] appFrame];
}

-(CGFloat)navbarHeight{
    return [[DDVCManager sharedManager] navbarHeight];
}

-(void)pushVC:(UIViewController *)vc{
    [[DDVCManager sharedManager] pushVC:vc];
}

-(void)popVC{
    [[DDVCManager sharedManager] popVC];
}

-(void)popToVC:(NSString *)vcName{
    [[DDVCManager sharedManager] popToVC:vcName];
}

-(void)popToRootVC{
    [[DDVCManager sharedManager] popToRootVC];
}

-(void)presentVC:(UIViewController *)vc{
    [[DDVCManager sharedManager] presentVC:vc];
}

-(void)dismissVC{
    [[DDVCManager sharedManager] dismissVC];
}

@end
