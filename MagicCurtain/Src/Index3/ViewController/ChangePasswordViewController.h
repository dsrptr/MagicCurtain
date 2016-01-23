//
//  ChangePasswordViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
- (IBAction)sendCode:(id)sender;
- (IBAction)post:(id)sender;

@end
