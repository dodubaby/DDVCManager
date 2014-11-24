//
//  DDVCManager.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "DDVCManager.h"
#import "AppDelegate.h"
#import "UIViewController+DDVCManager.h"
#import "DDVCAnimation.h"

@interface DDVCManager()
{
    NSMutableArray *vcStack;
}

@property (nonatomic,assign) DDAnimType animType;

@end

@implementation DDVCManager

-(id)init{
    
    if (self = [super init]) {
        vcStack = [[NSMutableArray alloc] init];
        _animType = DDAnimTypeClassic;
    }
    return self;
}

+(DDVCManager *)sharedManager{

    static DDVCManager *__vcManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __vcManager = [[DDVCManager alloc] init];
    });
    return __vcManager;
}

+(DDAnimType)animType{
    return [DDVCManager sharedManager].animType;
}

+(void)setAnimType:(DDAnimType)type{
    [DDVCManager sharedManager].animType = type;
}

-(void)setRootViewController:(UIViewController *)rootViewController{

    if (!rootViewController) {
        NSLog(@"## rootViewController can not be nil !");
        return;
    }
    
    // ignore root vc move
    [rootViewController setEnablePanRight:NO];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setBackgroundColor:[UIColor blackColor]];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setWindow:window];
    
    window.rootViewController = rootViewController;
    _rootViewController = rootViewController;
    
    _window = window;
    [_window makeKeyAndVisible];
    
    [vcStack removeAllObjects];
    [vcStack addObject:rootViewController];
}

-(CGRect)appFrame{
    CGFloat h = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        h = 20;  // status bar height
    }
    return CGRectMake(0, h, _window.frame.size.width, _window.frame.size.height-h);
}

-(CGFloat)navbarHeight{
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        return 44;
    }
    return 64;
}

-(UIViewController *)topVC{
    id vc = [vcStack lastObject];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

-(UIViewController *)preVC{
    if ([vcStack count]>1) {
        id vc = vcStack[vcStack.count - 2];
        if ([vc isKindOfClass:[UIViewController class]]) {
            return vc;
        }
    }
    return nil;
}

-(void)pushVC:(UIViewController *)vc{
    
    UIViewController *pre = [self topVC];
    UIViewController *cur = vc;
    
    
    id<DDVCAnimation> animation = nil;
    switch (_animType) {
        case DDAnimTypeClassic:
            animation = [DDVCAnimationClassic animation];
            break;
        case DDAnimTypeDepth:
            animation = [DDVCAnimationDepth animation];
            break;
        default:
            animation = [DDVCAnimationClassic animation];
            break;
    }

    [animation pushVC:cur
               topVC:pre
          completion:^(BOOL finished) {
        //
              [vcStack addObject:vc];
          }];
}

-(void)popVC{
    
    if ([vcStack count]<2) {
        return;
    }
    
    UIViewController *pre = (UIViewController *)vcStack[vcStack.count-2];
    UIViewController *cur = [[DDVCManager sharedManager] topVC];
    
    id<DDVCAnimation> animation = nil;
    switch (_animType) {
        case DDAnimTypeClassic:
            animation = [DDVCAnimationClassic animation];
            break;
        case DDAnimTypeDepth:
            animation = [DDVCAnimationDepth animation];
            break;
        default:
            animation = [DDVCAnimationClassic animation];
            break;
    }
    
    [animation popVC:cur
                preVC:pre
           completion:^(BOOL finished) {
               //
               [vcStack removeObject:cur];
           }];
    
}

-(void)popToVC:(NSString *)vcName{
    
    if ([[self topVC].name isEqualToString:vcName]) {
        return;
    }
    
    UIViewController *destVC = nil;
    int index = 0;
    
    for (int i = 0 ; i<[vcStack count]; i++) {
        UIViewController *vc = vcStack[i];
        if ([vcName isEqualToString:vc.name]) {
            destVC = vc;
            index = i;
            break;
        }
    }
    
    int popCount = (int)[vcStack count] - index-1;
    if (destVC) {
        for (int k = 0; k<popCount; k++) {
            [self popVC];
        }
    }else{
        NSLog(@"ViewController named %@ not found",vcName);
    }
}

-(void)popToRootVC{
    
    while ([vcStack count]>1) {
        [self popVC];
    }
}

-(void)presentVC:(UIViewController *)vc{

    UIViewController *pre = [self topVC];
    UIViewController *cur = vc;
    
    
    id<DDVCAnimation> animation = nil;
    switch (_animType) {
        case DDAnimTypeClassic:
            animation = [DDVCAnimationClassic animation];
            break;
        case DDAnimTypeDepth:
            animation = [DDVCAnimationDepth animation];
            break;
        default:
            animation = [DDVCAnimationClassic animation];
            break;
    }
    
    [animation presentVC:cur
               topVC:pre
          completion:^(BOOL finished) {
              //
          }];
    
    [vcStack addObject:vc];
    
    [vc setEnablePanRight:NO];
}

-(void)dismissVC{

    if ([vcStack count]<=1) {
        return;
    }
    
    UIViewController *pre = (UIViewController *)vcStack[vcStack.count-2];
    UIViewController *cur = [[DDVCManager sharedManager] topVC];
    
    id<DDVCAnimation> animation = nil;
    switch (_animType) {
        case DDAnimTypeClassic:
            animation = [DDVCAnimationClassic animation];
            break;
        case DDAnimTypeDepth:
            animation = [DDVCAnimationDepth animation];
            break;
        default:
            animation = [DDVCAnimationClassic animation];
            break;
    }
    
    [animation dismissVC:cur
                   preVC:pre
              completion:^(BOOL finished) {
                //
                [vcStack removeObject:cur];
              }];
}

@end
