//
//  RegistViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegistDelegate<NSObject>
-(void)getmobiel:(NSString *)mobile andPassowrd:(NSString *)password;
@end
@interface RegistViewController : UIViewController
- (IBAction)registAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)aggrenAction:(id)sender;
- (IBAction)postVerifyCode:(id)sender;
@property (weak, nonatomic)id<RegistDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *mobel;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UIButton *agreenBtn;
@property (weak, nonatomic) IBOutlet UIView *hidView;

@end
