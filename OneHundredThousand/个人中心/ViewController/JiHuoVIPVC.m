//
//  JiHuoVIPVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "JiHuoVIPVC.h"
#import "DeleteLineLabel.h"
#import "AFNetworking.h"

#import "AlipayModel.h"
# import <AlipaySDK/AlipaySDK.h>

@interface JiHuoVIPVC ()
@property (weak, nonatomic) IBOutlet UITextField *tuiJianMaTextF;
@property (weak, nonatomic) IBOutlet UIButton *chongZhiBt;

@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic) IBOutlet DeleteLineLabel *yuanYueLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiLabel;
@property (weak, nonatomic) IBOutlet DeleteLineLabel *yuanJiLabel;

@property (weak, nonatomic) IBOutlet UILabel *banNianLabel;
@property (weak, nonatomic) IBOutlet DeleteLineLabel *yuanBanNianLabel;

@property (weak, nonatomic) IBOutlet UILabel *nianLabel;
@property (weak, nonatomic) IBOutlet DeleteLineLabel *yuanNianLabel;

@property(assign,nonatomic)NSInteger  currentButton;
@end

@implementation JiHuoVIPVC

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipay" object:@"success"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值激活VIP";
    self.chongZhiBt.backgroundColor = RGB_Alpha(255, 213, 31, 1);
    self.currentButton = 1000;
    [self selectButtonWithTag:self.currentButton];

    Custom_Weak(chongZhiWeak)
    [ServiceTool getBaseWithUrl:@"http://39.108.151.95:8000/MyApp/user/getDicByGroup/1" Params:nil ShowHUD:YES success:^(id results) {
        NSArray * resultArray = results;
        for (int i =0;i<resultArray.count;i++ ) {
            if (i == 0) {
                chongZhiWeak.yueLabel.text = [NSString stringWithFormat:@"月卡%@元",resultArray[i][@"value1"]];
                chongZhiWeak.yuanYueLabel.text = [NSString stringWithFormat:@"原价%@元",resultArray[i][@"value2"]];

            }else if (i == 1) {
                chongZhiWeak.jiLabel.text = [NSString stringWithFormat:@"季卡%@元",resultArray[i][@"value1"]];
                chongZhiWeak.yuanJiLabel.text = [NSString stringWithFormat:@"原价%@元",resultArray[i][@"value2"]];
                
            }else if (i == 2) {
                chongZhiWeak.banNianLabel.text = [NSString stringWithFormat:@"半年卡%@元",resultArray[i][@"value1"]];
                chongZhiWeak.yuanBanNianLabel.text = [NSString stringWithFormat:@"原价%@元",resultArray[i][@"value2"]];
                
            }else if (i == 3) {
                chongZhiWeak.nianLabel.text = [NSString stringWithFormat:@"年卡%@元",resultArray[i][@"value1"]];
                chongZhiWeak.yuanNianLabel.text = [NSString stringWithFormat:@"原价%@元",resultArray[i][@"value2"]];
            }
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error-----%@",error);
    }];
    
    NSNotificationCenter * center =[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(alipaySuccess:) name:@"alipay" object:@"success"];
    
}
#pragma mark--支付宝支付成功调用的通知
- (void)alipaySuccess:(NSNotification *)notification{
    
    NSLog(@"-notification---%@",notification);
    
    if ([_delegate respondsToSelector:@selector(JiHuoVIPVCDelegateWithPaySuccess)]) {
        [_delegate JiHuoVIPVCDelegateWithPaySuccess];
    }
    
}
#pragma mark--充值
- (IBAction)chongZhiBtClick:(id)sender {

    NSString * isFirst = [NSString stringWithFormat:@"%@",User_Default_ObjectForKey(@"ifFirst")];
    if (![isFirst isEqualToString:@"1"] && _tuiJianMaTextF.text.length !=0) {
     
        Show_Toast(@"推荐码只有首充可以使用哦～", 0.8)
        return;
    }
    UILabel * label = [self.view viewWithTag:(self.currentButton + 300)];
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *  moneyStr =[label.text stringByTrimmingCharactersInSet:nonDigits];
    NSDictionary * dic = @{@"uid":User_Default_ObjectForKey(@"WX_Uid"),@"points":@(0.0),@"commendno":_tuiJianMaTextF.text,@"amount":[NSNumber numberWithDouble:moneyStr.doubleValue]};
    AFHTTPSessionManager *manager=[self getAFManager];
    NSURLSessionTask *sessionTask=nil;
    
    sessionTask = [manager POST:@"http://39.108.151.95:8000/MyApp/user/createOrder" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [AlipayModel payOrderPayMessage:responseString SuccessCallBack:^(NSDictionary *dic) {
            
            NSLog(@"-dicdicdicdic---%@",dic);
            
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-errorerrorerror--%@",error);
    }];
    
    
}

-(AFHTTPSessionManager *)getAFManager{
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=30;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
                                              @"application/json",
                                              @"text/html",
                                              @"text/json",
                                              @"text/plain",
                                              @"text/javascript",
                                              @"text/xml",
                                              @"text/css",
                                              @"multipart/form-data",
                                              @"image/*"
                                              ]];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
    
}
- (IBAction)kaButtonClick:(UIButton *)sender {
   
    if (sender.tag == self.currentButton) {
        return;
    }
    UIButton * oldButton = [self.view viewWithTag:self.currentButton];
    UIView * oldButtonSupView = oldButton.superview;
    oldButtonSupView.backgroundColor = RGB_Alpha(200, 200, 200, 1);
    [self selectButtonWithTag:sender.tag];
    self.currentButton = sender.tag;
    
    
    
}
-(void)selectButtonWithTag:(NSInteger)tag{
    
    UIButton * button = [self.view viewWithTag:tag];
    UIView * buttonSupView = button.superview;
    buttonSupView.backgroundColor = RGB_Alpha(255, 213, 31, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
