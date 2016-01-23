//
//  CreatOrderViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/10.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "CreatOrderViewController.h"
#import "TitleCell.h"
#import "AliPayorWeChatCell.h"
#import "IndexService.h"
#import "Create_pay_order.h"
#import "AlixPayOrder.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "DataSigner.h"
@interface CreatOrderViewController ()<AliPayorWeChatDelegate>
{
    AliPayorWeChatCell *selectCell;
    NSMutableArray *cellArray;
    IndexService *indexService;
    LoginModel *user;
}
@end

@implementation CreatOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _price.text=_payMoney;
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    cellArray=[NSMutableArray new];
    indexService=[IndexService new];
    self.tableView.tableFooterView=[UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
    return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        TitleCell*cell =[tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        cell.price.text=_payMoney;
        return cell;
    }else{
        AliPayorWeChatCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AliPayorWeChatCell" forIndexPath:indexPath];
        cell.tag=indexPath.row;
        [cellArray addObject:cell];
        cell.delegate=self;
        if (indexPath.row==0) {
            cell.picture.image=[UIImage imageNamed:@"ic_alipay_plugin_enabled"];
            cell.title.text=@"支付宝支付";
            selectCell=cell;
        }else{
            cell.picture.image=[UIImage imageNamed:@"ic_weixinpay_enabled"];
            [cell.choose setBackgroundColor:[UIColor clearColor]];
            cell.title.text=@"微信支付";
            cell.detaile.text=@"微信支付";
            cell.backVIew.backgroundColor=[UIColor whiteColor];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if(indexPath.section==1){
        return 62;
    }
    return 33;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}

-(void)choosePayType:(NSInteger)index inCell:(AliPayorWeChatCell*)cell{
    for (int i=0; i<cellArray.count; i++) {
        selectCell=cellArray[i];
        selectCell.backVIew.backgroundColor=[UIColor whiteColor];
    }
    selectCell=cell;
    cell.backVIew.backgroundColor=[SharedAction colorWithHexString:@"00B050"];
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postAction:(id)sender {
    if (selectCell.tag==0) {
        [indexService create_orderWithSecret:user.secret andLesson_id:self.lessonId andMoney:self.payMoney andPayModel:@"pay_alipay" andMid:user.mid andLessonType:self.lessonType withViewController:self withDone:^(Create_pay_orderInfo *model){
            NSString *appScheme = @"MagicCurtain";
            NSString* orderInfo = [self getOrderInfoWithCreate_pay_orderInfo:model andPrice:self.payMoney];
            NSString* signedStr = [self doRsa:orderInfo andPrivateKey:model.private];
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                     orderInfo, signedStr, @"RSA"];
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"%@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.lessonType,@"lessonType",self.lessonId,@"lessonId",self.indexPath,@"indexPath",nil];
                    //创建通知
                    NSNotification *notification =[NSNotification notificationWithName:@"PaySuccess" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter]postNotification:notification];
                    [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:[resultDic objectForKey:@"memo"]];
                }
            }];
        }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"暂不支持微信支付！请使用支付宝支付!"];
        return;
        [indexService jumpToBizPay];
    }
}


-(NSString*)getOrderInfoWithCreate_pay_orderInfo:(Create_pay_orderInfo *)model andPrice:(NSString *)price
{
//    SharedData *sharedData = [SharedData sharedInstance];
//    UserInfo *user = sharedData.user;
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = model.default_partner;
    order.seller = model.default_seller;
    order.tradeNO = model.out_trade_no; //订单ID（由商家自行制定）
    order.productName = [NSString stringWithFormat:self.lessonName]; //商品标题
    order.productDescription = @"摆布学院课程购买"; //商品描述
    order.amount = price; //商品价格
    order.notifyURL = model.notify_url; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo andPrivateKey:(NSString *)privateKey
{
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

@end
