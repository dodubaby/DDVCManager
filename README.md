DDVCManager
===========

a lightweight library to manager ours UIViewController without UINavigationController

How to use
===========
### Step 1

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DDHomeViewController *root =  [[DDHomeViewController alloc] initWithName:@"DDHomeViewController0"];
    root.leftNavButtonHidden = YES;
    [[DDVCManager sharedManager] setRootViewController:root];
    [DDVCManager setAnimType:DDAnimTypeDepth]; // animation type DDAnimTypeDepth/DDAnimTypeClassic
    
    return YES;
}
```

### Step 2
in ours viewcontroller use  UIViewController's category methods
```objectivec
[self pushVC:vc];
[self popVC];
[self popToRootVC];
[self popToVC:vcName];

[self presentVC:vc];
[self dismissVC];

```
also, we can use DDVCManager derectly

```objectivec
DDVCManager *manager = [DDVCManager sharedManager];

[manager pushVC:vc];
[manager popVC];
[manager popToRootVC];
[manager popToVC:vcName];

[manager presentVC:vc];
[manager dismissVC];

```
