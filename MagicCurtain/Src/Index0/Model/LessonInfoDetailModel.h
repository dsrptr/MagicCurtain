//
//  LessonInfoDetailModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Lesson_SubInfo <NSObject>
@end

@protocol LessonInfoDetailInfo <NSObject>
@end

@protocol LessonWithInfo <NSObject>
@end

@protocol Lesson_MessageInfo <NSObject>
@end



@interface LessonWithInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *picture;
@property(nonatomic,strong)NSString<Optional> *duration;
@property(nonatomic,strong)NSString<Optional> *play_nums;
@property(nonatomic,strong)NSString<Optional> *lesson_free;
@property(nonatomic,assign)NSInteger is_collect;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger is_pay;
@end
@interface Lesson_SubInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *video_url;
@end

@interface LessonInfoDetailInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *intro;
@property(nonatomic,strong)NSString<Optional> *share_url;
@property(nonatomic,strong)NSArray<Lesson_SubInfo,Optional> *lesson_sub;

@end
@interface LessonInfoDetailModelInfo : JSONModel
@property(nonatomic,strong)NSArray<LessonInfoDetailInfo,Optional> *lesson;
@property(nonatomic,strong)NSArray<LessonWithInfo,Optional> *lesson_with;
@property(nonatomic,strong)NSArray<Lesson_MessageInfo,Optional> *lesson_message;
@end
@interface LessonInfoDetailModel : JSONModel
@property(nonatomic,strong)LessonInfoDetailModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
