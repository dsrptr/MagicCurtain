//
//  Index2ViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index2ViewController.h"
#import "RMPickerViewController.h"
#import "CalcTypeModel.h"
#import "InputCell.h"
#import "PrintCell.h"
#import "ChooseCell.h"
#import "WebViewController.h"
#import "Index2Service.h"
#import "NSString+MT.h"
@interface Index2ViewController ()<RMPickerViewControllerDelegate,ChooseCellDelegate>
{
    UITapGestureRecognizer *hidKeyboardTap;
    Index2Service *index2Service;
    LoginModel *user;
    NSArray *dataSouce;
    NSInteger inputCount;
    NSInteger outCount;
    CalcTypeModelCalc_TypeInfo *chooseModel;
    NSString *calcid;
    NSString *calcName;
    NSMutableArray *cellArray;
    NSMutableDictionary *keyValueDict;
    
}
@property (nonatomic,retain) RMPickerViewController *pickerVC;
@end

@implementation Index2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"计算";
    keyValueDict=[NSMutableDictionary new];
    cellArray=[NSMutableArray new];
    inputCount=0;
    outCount=0;
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    index2Service =[Index2Service new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserInfo) name:@"LoginSuccess" object:nil];
    hidKeyboardTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidKeyboard)];
    [self.view addGestureRecognizer:hidKeyboardTap];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.btnWidth.constant=DeviceFrame.size.width-132;
    self.inputTableView.tableFooterView=[UIView new];
    self.printtableView.tableFooterView=[UIView new];
    self.deleatBtn.layer.cornerRadius=2;
    self.calculateBtn.layer.cornerRadius=2;
    self.demonstrationBtn.layer.cornerRadius=2;
    [self calctype];
       // Do any additional setup after loading the view.
}

-(void)getUserInfo{
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    [self calctype];
}

-(void)calctype{
    
    [index2Service calctypeWithMid:user.mid andSecret:user.secret
                withViewController:self
                          withDone:^(CalcTypeModelInfo *model){
        dataSouce =model.calc_type;
        CalcTypeModelCalc_TypeInfo *models =dataSouce[0];
        chooseModel=models;
        self.inputHeight.constant=models.input.count*40+8+37;
        inputCount=models.input.count;
        self.printHeight.constant=models.out.count*37;
        outCount=models.out.count;
        calcid=chooseModel.calc_id;
        calcName=chooseModel.name;
        [self.inputTableView reloadData];
        [self.printtableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==0) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag==0) {
        if (section==0) {
            return 8;
        }
        return 0;
    }else{
        return 0;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        if (section==0) {
            return 1;
        }
        return inputCount;
    }
    return outCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        if (indexPath.section==0) {
            ChooseCell*cell =[tableView dequeueReusableCellWithIdentifier:@"ChooseCell" forIndexPath:indexPath];
            [cell.choseBtn setTitle:chooseModel.name forState:UIControlStateNormal];
            cell.delegate=self;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        InputCell*cell =[tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath];
        InputInfo *model =chooseModel.input[indexPath.row];
        cell.tag=indexPath.row;
        cell.name.text=model.name;
        cell.inputSize.placeholder=model.prompt;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cellArray addObject:cell];
        return cell;
    }else{
        InputInfo *model =chooseModel.out[indexPath.row];
        PrintCell*cell =[tableView dequeueReusableCellWithIdentifier:@"PrintCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.name.text=model.name;
        if (indexPath.row==chooseModel.out.count) {
            return cell;
        }
        if ([keyValueDict valueForKey:model.item]) {
            if ([[keyValueDict valueForKey:model.item] isKindOfClass:[NSNumber class]]) {
                cell.print.text=[NSString stringWithFormat:@"%@",[keyValueDict valueForKey:model.item]];
            }else{
                cell.print.text=[keyValueDict valueForKey:model.item];
            }
        }else{
            cell.print.text=@"";
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (tableView.tag==1) {
        return 37;
    }
  
//    return [NSString widthWithString:string font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-60, 80)];
//     cell.print.text=[keyValueDict valueForKey:model.item];
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)chooseList{
    [self setPickwithDatas:@[]];
}

-(void)setPickwithDatas:(NSArray *)datas{
    self.pickerVC = [RMPickerViewController pickerController];
    self.pickerVC.delegate = self;
    self.pickerVC.titleLabel.text = @"选择";
    self.pickerVC.disableBlurEffects = YES;
    [self.pickerVC show];
}

#pragma mark - RMPickerViewController Delegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return dataSouce.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CalcTypeModelCalc_TypeInfo *model=dataSouce[row];
    return model.name;
}

- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    chooseModel =dataSouce[[selectedRows[0] integerValue]];
    self.inputHeight.constant=chooseModel.input.count*40+8+37;
    inputCount=chooseModel.input.count;
    self.printHeight.constant=chooseModel.out.count*37;
    outCount=chooseModel.out.count;
    calcid=chooseModel.calc_id;
    calcName=chooseModel.name;
    for (int i=0; i<cellArray.count; i++) {
        InputCell *cell=cellArray[i];
        cell.inputSize.text=@"";
    }
    [cellArray removeAllObjects];
    [keyValueDict removeAllObjects];
    [self.inputTableView reloadData];
    [self.printtableView reloadData];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%ld",(long)row);
}

-(void)hidKeyboard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)calculateAction:(id)sender {
    [self hidKeyboard];
    NSMutableArray *keyWordArray=[NSMutableArray new];
    NSMutableArray *valueArray=[NSMutableArray new];
    for (int i=0; i<chooseModel.input.count; i++) {
        InputInfo *model =chooseModel.input[i];
        [keyWordArray addObject:model.item];
    }
    for (int i=0; i<cellArray.count; i++) {
        InputCell *cell=cellArray[i];
        if ([cell.inputSize.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"参数不能为空!"];
            return;
        }
        [valueArray addObject:cell.inputSize.text];
    }
    NSString *inputString ;
    inputString=@"";
    for (int i=0; i<cellArray.count; i++) {
        if ([inputString isEqualToString:@""]) {
            inputString=[NSString stringWithFormat:@"%@:%@",keyWordArray[i],valueArray[i]];
        }else{
            inputString=[NSString stringWithFormat:@"%@;%@:%@",inputString,keyWordArray[i],valueArray[i]];
        }
    }
       [index2Service calcCalcWithMid:user.mid
                            andSecret:user.secret
                            andCalcid:calcid
                             andInput:inputString
                   withViewController:self
                             withDone:^(NSDictionary *dict){
           [keyValueDict removeAllObjects];
        NSArray *keyArray=[dict allKeys];
        NSArray *valueArray=[dict allValues];
        for (int i=0; i<keyArray.count; i++) {
            [keyValueDict setObject:valueArray[i] forKey:keyArray[i]];
        }
           [self.printtableView reloadData];
    }];
}

- (IBAction)deleatAction:(id)sender {
    [self hidKeyboard];
    for (int i=0; i<cellArray.count; i++) {
        InputCell *cell=cellArray[i];
        cell.inputSize.text=@"";
        }
    [keyValueDict removeAllObjects];
    [self.printtableView reloadData];

}

- (IBAction)DemonstrationAction:(id)sender {
    [self hidKeyboard];
    NSMutableArray *keyWordArray=[NSMutableArray new];
    NSMutableArray *valueArray=[NSMutableArray new];
    for (int i=0; i<chooseModel.input.count; i++) {
        InputInfo *model =chooseModel.input[i];
        [keyWordArray addObject:model.item];
    }
    for (int i=0; i<cellArray.count; i++) {
        InputCell *cell=cellArray[i];
        if ([cell.inputSize.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"参数不能为空!"];
            return;
        }
        [valueArray addObject:cell.inputSize.text];
    }
    NSString *inputString ;
    inputString=@"";
    for (int i=0; i<cellArray.count; i++) {
        if ([inputString isEqualToString:@""]) {
            inputString=[NSString stringWithFormat:@"%@:%@",keyWordArray[i],valueArray[i]];
        }else{
            inputString=[NSString stringWithFormat:@"%@;%@:%@",inputString,keyWordArray[i],valueArray[i]];
        }
    }
    
    [index2Service calcDrawWithMid:user.mid andSecret:user.secret
                        andCalc_id:calcid
                          andInput:inputString
                withViewController:self
                          withDone:^(NSString *urlString){
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.navigationController.navigationItem.leftBarButtonItem.title=@"首页";
        target.title=calcName;
        target.urlString = urlString;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }];
}

- (IBAction)choseCalc:(id)sender {
}
@end
