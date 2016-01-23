//
//  LoginViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)dismissAction:(id)sender;
- (IBAction)fogotAction:(id)sender;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
