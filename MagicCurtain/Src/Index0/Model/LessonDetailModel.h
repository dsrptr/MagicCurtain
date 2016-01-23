//
//  LessonDetailModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol LessonWithInfoModelInfo<NSObject>

@end

@interface LessonWithInfoModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *picture;
@property(nonatomic,strong)NSString<Optional> *duration;
@property(nonatomic,strong)NSString<Optional> *play_nums;
@property(nonatomic,strong)NSString<Optional> *free_type;
@property(nonatomic,strong)NSString<Optional> *click_like;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger is_pay;
@property(nonatomic,assign)NSInteger is_collect;
@end
@protocol LessonSubInfoModelInfo<NSObject>

@end

@interface LessonSubInfoModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *video_url;
@end

@protocol LessonMessageReplyModelInfo<NSObject>

@end

@interface LessonMessageReplyModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *message;
@property(nonatomic,strong)NSString<Optional> *reg_name;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@property(nonatomic,strong)NSString<Optional> *reg_id;
@property(nonatomic,strong)NSString<Optional> *head_image;
@end

@protocol LessonMessageInfoModelInfo<NSObject>
@end

@interface LessonMessageInfoModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *message_id;
@property(nonatomic,strong)NSString<Optional> *message;
@property(nonatomic,strong)NSString<Optional> *reg_name;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@property(nonatomic,strong)NSString<Optional> *head_image;
@property(nonatomic,strong)NSArray<LessonMessageReplyModelInfo,Optional> *message_reply;
@end

@interface LessonDetailInfoModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *share_url;
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *intro;
@property(nonatomic,strong)NSArray <LessonWithInfoModelInfo,Optional> *lesson_with;
@property(nonatomic,strong)NSArray <LessonSubInfoModelInfo,Optional> *lesson_sub;
@property(nonatomic,strong)NSArray <LessonMessageInfoModelInfo,Optional> *lesson_message;
@end
@interface LessonDetailModelInfo : JSONModel
@property(nonatomic,strong)LessonDetailInfoModelInfo<Optional> *lesson;
@end


@interface LessonDetailModel : JSONModel
@property(nonatomic,strong)LessonDetailModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
