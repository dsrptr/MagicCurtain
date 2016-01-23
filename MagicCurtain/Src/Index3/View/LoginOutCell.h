//
//  LoginOutCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/11.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginOutDeleGate<NSObject>
-(void)loginOut;
@end
@interface LoginOutCell : UITableViewCell
- (IBAction)loginoutAction:(id)sender;
@property (weak,nonatomic)id<LoginOutDeleGate>delegate;
@end
