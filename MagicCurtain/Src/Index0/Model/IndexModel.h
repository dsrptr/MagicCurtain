//
//  IndexModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Lesson_typeInfo<NSObject>
@end

@protocol AdvertInfo<NSObject>
@end
@protocol Lesson_newInfo <NSObject>
@end
@interface Lesson_newInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *picture;
@property(nonatomic,strong)NSString<Optional> *duration;
@property(nonatomic,strong)NSString<Optional> *paly_nums;
@property(nonatomic,strong)NSString<Optional> *free_type;
@property(nonatomic,strong)NSString<Optional> *click_like;
@property(nonatomic,assign)NSInteger is_collect;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger is_pay;
@end
@interface Lesson_typeInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_type;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *picture;
@end
@interface AdvertInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *advert_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *advert_url;
@property(nonatomic,strong)NSString<Optional> *picture;
@end
@interface IndexModelInfo : JSONModel
@property(nonatomic,strong)NSArray <AdvertInfo,Optional>*advert;
@property(nonatomic,strong)NSArray  <Lesson_typeInfo,Optional> *lesson_type;
@property(nonatomic,strong)NSArray  <Lesson_newInfo,Optional> *lesson_new;
//@property(nonatomic,strong)NSArray  <Lesson_newInfo,Optional> *lesson_free;
@property(nonatomic,assign)NSInteger push_size;
@end
@interface IndexModel : JSONModel
@property(nonatomic,strong)IndexModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;

@end
