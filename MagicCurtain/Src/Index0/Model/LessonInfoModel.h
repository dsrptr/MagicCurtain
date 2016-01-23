//
//  LessonInfoModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol LessonInfoModel<NSObject>

@end

@interface LessonInfoModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *demo;
@property(nonatomic,strong)NSString<Optional> *picture;
@property(nonatomic,strong)NSString<Optional> *duration;
@property(nonatomic,strong)NSString<Optional> *play_nums;
@property(nonatomic,strong)NSString<Optional> *free_type;
@property(nonatomic,strong)NSString<Optional> *intro;
@property(nonatomic,strong)NSString<Optional> *message_nums;
@property(nonatomic,strong)NSString<Optional> *click_like;
@property(nonatomic,assign)NSInteger is_collect;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger is_pay;
@end
