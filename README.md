DDVCManager
===========

DDVCManager

How to use
===========
### Step 1

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DDHomeViewController *root =  [[DDHomeViewController alloc] initWithName:@"DDHomeViewController0"];
    root.leftNavButtonHidden = YES;
    [[DDVCManager sharedManager] setRootViewController:root];
    [DDVCManager setAnimType:DDAnimTypeDepth];
    
    return YES;
}
```
