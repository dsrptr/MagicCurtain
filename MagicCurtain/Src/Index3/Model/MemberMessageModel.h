//
//  MemberMessageModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol MemberMessageReplyDetailInfo <NSObject>
@end

@protocol MemberMessageDetailInfo <NSObject>
@end

@interface MemberMessageReplyDetailInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *message;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@end
@interface MemberMessageDetailInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *message_id;
@property(nonatomic,strong)NSString<Optional> *block_type;
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *message;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSArray<MemberMessageReplyDetailInfo,Optional> *message_reply;
@end
@interface MemberMessageDetail : JSONModel
@property(nonatomic,strong)NSArray<MemberMessageDetailInfo,Optional> *message;
@end

@interface MemberMessageModel : JSONModel
@property(nonatomic,strong)MemberMessageDetail<Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
