//
//  DDBaseViewController.m
//  DDVCManager
//
//  Created by bright on 14/11/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDVCManager.h"

@interface DDBaseViewController ()<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *pan;
    
    CGPoint start;
    CGPoint end;
}

@property (nonatomic,strong) UIView *navbar;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation DDBaseViewController

-(id)initWithName:(NSString *)name{
    self = [super initWithName:name];
    if (self) {
        _leftNavButtonHidden = NO;
    }
    return self;
}

-(void)backButtonTaped:(id)sender{
    [self popVC];
}

-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    _titleLabel.text = _navTitle;
}

-(void)setLeftNavButtonHidden:(BOOL)leftNavButtonHidden{
    _leftNavButtonHidden = leftNavButtonHidden;
    _backButton.hidden = _leftNavButtonHidden;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.layer.masksToBounds = NO;
    self.view.layer.shadowOpacity = 0.3f;
    self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 3, self.view.bounds.size.height)] CGPath];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    
    
    CGFloat h = 0;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>7.0) {
        h = 20;
    }
    
    _navbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44+h)];
    _navbar.backgroundColor = [UIColor colorWithRed:135/255.0 green:187/255.0 blue:127/255.0 alpha:1.0f];
    [self.view addSubview:_navbar];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0+h, self.view.frame.size.width-2*35, 44)];
    [self.view addSubview:_titleLabel];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _navTitle;
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"nav_back_button"] forState:UIControlStateNormal];
    _backButton.backgroundColor = [UIColor clearColor];
    [_navbar addSubview:_backButton];
    _backButton.frame = CGRectMake(0, 0+h, 40, 40);
    [_backButton addTarget:self action:@selector(backButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    _backButton.hidden = _leftNavButtonHidden;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint location =  [gesture locationInView:[DDVCManager sharedManager].window];
        start = location;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {

        CGPoint location =  [gesture locationInView:[DDVCManager sharedManager].window];
        end =  location;
        
        CGFloat x = end.x - start.x;
        if (x>0) {  // move right
            UIView *preView = [DDVCManager sharedManager].preVC.view;
            UIView *curView = self.view;
            
            
            CGFloat h = [DDVCManager sharedManager].appFrame.origin.y;
            
            if ([DDVCManager animType] == DDAnimTypeClassic) {
                [UIView animateWithDuration:0.1 animations:^{
                    preView.frame = CGRectMake(-[DDVCManager sharedManager].appFrame.size.width/3.0f+x/3.0f, 0, preView.frame.size.width, preView.frame.size.height);
                    
                    curView.frame = CGRectMake(0+x, h, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished) {
                }];

            }else{
                [UIView animateWithDuration:0.1 animations:^{
                    //                preView.frame = CGRectMake(-[QUIVCManager sharedManager].appFrame.size.width/3.0f+x/3.0f, 0, preView.frame.size.width, preView.frame.size.height);
                    
                    
                    CGFloat scale = 0.1*x/[DDVCManager sharedManager].appFrame.size.width;
                    
                    preView.transform = CGAffineTransformMakeScale(0.9+scale,0.9+scale);
                    
                    curView.frame = CGRectMake(0+x, h, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished) {
                }];
            
            }
            
        }
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded ||
        gesture.state == UIGestureRecognizerStateCancelled||
        gesture.state == UIGestureRecognizerStateFailed) {
        
        CGFloat x = end.x - start.x;
        if (x>[[DDVCManager sharedManager] appFrame].size.width/3.0f) { // pop
            [self popVC];
        }else{    // reset
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

            UIView *preView = [DDVCManager sharedManager].preVC.view;
            UIView *curView = self.view;
            
            if ([DDVCManager animType] == DDAnimTypeClassic) {
                [UIView animateWithDuration:0.3 animations:^{
                    
                    preView.frame = CGRectMake(-[DDVCManager sharedManager].appFrame.size.width/3.0f, 0, preView.frame.size.width, preView.frame.size.height);
                    curView.frame = [[DDVCManager sharedManager] appFrame];
                    
                } completion:^(BOOL finished) {
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }];

            }else{
            
                [UIView animateWithDuration:0.3 animations:^{
                    
                    //                preView.frame = CGRectMake(-[QUIVCManager sharedManager].appFrame.size.width/3.0f, 0, preView.frame.size.width, preView.frame.size.height);
                    
                    preView.transform = CGAffineTransformMakeScale(0.9,0.9);
                    
                    curView.frame = [[DDVCManager sharedManager] appFrame];
                    
                } completion:^(BOOL finished) {
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }];
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // ignore some view  UIScrollView  UISlider etc.
    
    NSArray *ignoreClazz = @[@"UISlider"];
    
    for (NSString *item in ignoreClazz) {
        Class clazz = NSClassFromString(item);
        if ([touch.view isKindOfClass:clazz]||[touch.view.superview isKindOfClass:clazz]) {
            return NO;
        }
    }
    
	return self.enablePanRight;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    return self.enablePanRight;;
}

-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"viewWillAppear %@",self.name);
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"viewDidAppear %@",self.name);
}

-(void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"viewWillDisappear %@",self.name);
}

-(void)viewDidDisappear:(BOOL)animated{
    
    NSLog(@"viewDidDisappear %@",self.name);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    pan.delegate = nil;
    pan = nil;
    
    NSLog(@"dealloc ### %@",self.name);
}

@end
