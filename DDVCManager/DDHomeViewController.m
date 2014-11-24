//
//  DDHomeViewController.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "DDHomeViewController.h"

@interface DDHomeViewController ()



@end

@implementation DDHomeViewController

static int k = 0;


-(void)backButtonTaped:(id)sender{

    if (_isPushed) {
        [self popVC];
    }else{
        [self dismissVC];
    }
}

-(void)push1:(id)sender{
    
    k++;
    
    DDHomeViewController *vc = [[DDHomeViewController alloc] initWithName:[NSString stringWithFormat:@"%@%d",NSStringFromClass([self class]),k]];
    vc.enablePanRight = YES;
    vc.isPushed = YES;
    
    [self pushVC:vc];
    

}

-(void)push2:(id)sender{
    
    k++;
    
    DDHomeViewController *vc = [[DDHomeViewController alloc] initWithName:[NSString stringWithFormat:@"%@%d",NSStringFromClass([self class]),k]];
    vc.enablePanRight = NO;
    vc.isPushed = YES;
    
    [self pushVC:vc];
    
    
}

-(void)present:(id)sender{
    
    k++;
    
    DDHomeViewController *vc = [[DDHomeViewController alloc] initWithName:[NSString stringWithFormat:@"%@%d",NSStringFromClass([self class]),k]];
    
    vc.isPushed = NO;
    
    [self presentVC:vc];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navTitle = [NSString stringWithFormat:@"DDHomeViewController(%d)",k];
    
    // Do any additional setup after loading the view.
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"Push (enable pan right)" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        button.frame = CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 44);
        [button addTarget:self action:@selector(push1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"Push (disable pan right)" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        button.frame = CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 44);
        [button addTarget:self action:@selector(push2:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"Present" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        button.frame = CGRectMake((self.view.frame.size.width-200)/2, 300, 200, 44);
        [button addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
