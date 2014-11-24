//
//  DDBaseViewController.h
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DDVCManager.h"


@interface DDBaseViewController : UIViewController

@property(nonatomic,strong) NSString *navTitle;

@property(nonatomic,assign) BOOL leftNavButtonHidden;

@end
