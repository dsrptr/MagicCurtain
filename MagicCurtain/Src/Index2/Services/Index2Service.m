//
//  Index2Service.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/7.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index2Service.h"
#import "CalcTypeModel.h"
#import "CalcResultModel.h"
#import "CalcDrawModel.h"

#define Calc_Type_URL [BaseUrl stringByAppendingString:@"Calc/calc_type/mid/%@/secret/%@"]
#define Calc_URL [BaseUrl stringByAppendingString:@"Calc/calc/mid/%@/secret/%@/calc_id/%@/input/%@"]
#define Calc_Draw_URL [BaseUrl stringByAppendingString:@"Calc/calc_draw/mid/%@/secret/%@/calc_id/%@/input/%@"]

@implementation Index2Service
-(void)calctypeWithMid:(NSString *)mid
             andSecret:(NSString *)secret
    withViewController:(UIViewController *)viewcontroller
              withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Calc_Type_URL,mid,secret];
    
    [CalcTypeModel getModelFromURLWithString:urlString completion:^(CalcTypeModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}
-(void)calcCalcWithMid:(NSString *)mid
             andSecret:(NSString *)secret
             andCalcid:(NSString *)calcid
              andInput:(NSString*)input
    withViewController:(UIViewController *)viewcontroller
              withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Calc_URL,mid,secret,calcid,input];
    [CalcResultModel getModelFromURLWithString:urlString completion:^(CalcResultModel *model,JSONModelError *error){
        CalcResultModelInfo *object=model.info;
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:object.calc_result
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)calcDrawWithMid:(NSString *)mid
             andSecret:(NSString *)secret
            andCalc_id:(NSString *)calc_id
              andInput:(NSString*)input
    withViewController:(UIViewController*)viewcontroller
              withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Calc_Draw_URL,mid,secret,calc_id,input];
    [CalcDrawModel getModelFromURLWithString:urlString completion:^(CalcDrawModel *model,JSONModelError *error){
        CalcDrawModelInfo *object=model.info;
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:object.draw_url
                       withViewController:viewcontroller
                                 withDone:done];
    }];

}


@end
