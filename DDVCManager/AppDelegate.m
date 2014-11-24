//
//  AppDelegate.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "AppDelegate.h"
#import "DDVCManager.h"
#import "DDHomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DDHomeViewController *root =  [[DDHomeViewController alloc] initWithName:@"DDHomeViewController0"];
    root.leftNavButtonHidden = YES;
    [[DDVCManager sharedManager] setRootViewController:root];
    [DDVCManager setAnimType:DDAnimTypeDepth];
    
    return YES;
}

@end
