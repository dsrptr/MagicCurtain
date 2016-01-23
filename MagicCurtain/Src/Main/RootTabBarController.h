//
//  RootTabBarController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController
@property (weak, nonatomic) IBOutlet UITabBar *tabBarcontroller;
@property (assign, nonatomic)NSInteger indexs;
@property (strong, nonatomic)NSString *lessonType;
-(void)setIndex:(NSInteger)index andLessonType:(NSString *)lessontype;
@end
