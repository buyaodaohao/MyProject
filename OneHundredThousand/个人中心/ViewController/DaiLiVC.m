//
//  DaiLiVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "DaiLiVC.h"

#import "AlertView.h"
#import "DaiLiBottomCell.h"
#import "PersonOtherCell.h"

#import "AFNetworking.h"

@interface DaiLiVC ()<UITableViewDelegate,UITableViewDataSource,ZKKAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *daiLiTableV;
@property(strong,nonatomic)AlertView * alertView;

@property(strong,nonatomic)NSMutableDictionary * resultDics;

@property(strong,nonatomic)NSMutableDictionary * biLiDics;

@property(strong,nonatomic)NSMutableDictionary * maiSiGuiZeDics;

@end

@implementation DaiLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"代理我们";
    
    [self.daiLiTableV registerNib:[UINib nibWithNibName:@"PersonOtherCell" bundle:nil] forCellReuseIdentifier:@"PersonOtherCell"];
    self.resultDics = [[NSMutableDictionary alloc]init];
    
    [self.daiLiTableV registerNib:[UINib nibWithNibName:@"DaiLiBottomCell" bundle:nil] forCellReuseIdentifier:@"DaiLiBottomCell"];
    self.resultDics = [[NSMutableDictionary alloc]init];
    self.biLiDics = [[NSMutableDictionary alloc]init];
    self.maiSiGuiZeDics = [[NSMutableDictionary alloc]init];
    
    [self requestDaiLiMessage];
    Custom_Weak(daiLiWeak)

//    当前迈思币的兑换比例
    [ServiceTool getBaseWithUrl:@"http://39.108.151.95:8000/MyApp/user/getValueWithKey/maisibiRate" Params:nil ShowHUD:YES success:^(id results) {
        daiLiWeak.biLiDics = results;
        [self.daiLiTableV reloadData];
        
    } fail:^(NSError *error) {
    }];
//    获取迈思币规则
    [ServiceTool getBaseWithUrl:@"http://39.108.151.95:8000/MyApp/user/getRemarkWithKey/maisibi" Params:nil ShowHUD:YES success:^(id results) {
        daiLiWeak.maiSiGuiZeDics = results;
        [self.daiLiTableV reloadData];
        
    } fail:^(NSError *error) {
    }];
    
}
-(void)requestDaiLiMessage{
  
    Custom_Weak(daiLiWeak)
    //    http://39.108.151.95:8000/MyApp/user/getCommendNo/oEtQjv6WA4ODD9R-T9w_3IIZFWYc
    //    代理我们
    [ServiceTool getBaseWithUrl:[NSString stringWithFormat:@"http://39.108.151.95:8000/MyApp/user/getCommendNo/%@",User_Default_ObjectForKey(@"WX_Uid")] Params:nil ShowHUD:YES success:^(id results) {
        daiLiWeak.resultDics = results;
        [self.daiLiTableV reloadData];
        
    } fail:^(NSError *error) {
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 2){
        return 3;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        DaiLiBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DaiLiBottomCell" forIndexPath:indexPath];
        if (self.maiSiGuiZeDics.count >0) {
            cell.contentLabel.text = self.maiSiGuiZeDics[@"remarkValue"];
        }
        return cell;
    }
    PersonOtherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonOtherCell" forIndexPath:indexPath];
    cell.currentIndex = indexPath;
    cell.isDaiLiViewController = NO;
    if (self.resultDics.count >0) {
     
        cell.rightLabel.text = @"";
        if (indexPath.section == 0) {
            cell.rightLabel.text = indexPath.row == 0 ?self.resultDics[@"commendNo"]:self.resultDics[@"uid"];
        }else if (indexPath.section == 1){
            cell.rightLabel.text = [NSString stringWithFormat:@"%.1f迈思币\n当前兑换人民币为：%.1f元",[self.resultDics[@"commendLeft"] floatValue],[self.resultDics[@"commend2cash"] floatValue]];
        }else if (indexPath.section == 2 && indexPath.row == 0){
            if (self.biLiDics.count >0) {
                cell.rightLabel.text = self.biLiDics[@"value2"];
            }
        }
    }
    if (APP_Width == 320) {
        cell.rightLabel.font = [UIFont systemFontOfSize:12.f];
    }
    
    return cell;
    
}
#pragma mark--提现／转账
-(void)ZKKAlertViewDelegateSelectStyle:(NSString *)stryle{
    
    if (self.resultDics.count == 0) {
        Show_Toast(@"请链接网络重新请求", 0.8)
        return;
    }
    
    if ([stryle isEqualToString:@"提现"]) {
//        提现的支付宝：625387857@qq.com。江勇
        CGFloat allMoney = [self.resultDics[@"commendLeft"] floatValue]
        * [self.biLiDics[@"value1"] floatValue];
        
         NSDictionary * dic = @{@"uid":self.resultDics[@"uid"],@"maisibi":self.resultDics[@"commendLeft"],@"payeeAccount":self.alertView.topTextF.text,@"amount":@(allMoney)};
        
        
        AFHTTPSessionManager *manager=[self getAFManager];
        NSURLSessionTask *sessionTask=nil;
        
        sessionTask = [manager POST:@"http://39.108.151.95:8000/MyApp/alipay/alitransfer" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"responseStringresponseString----%@", responseString);
            if ([responseString isEqualToString:@"success"]) {
                Show_Toast(@"迈思币提现成功", 0.8)
                Custom_Weak(daiLiWeak)
                [daiLiWeak requestDaiLiMessage];
            }
            Show_Toast(@"迈思币提现失败", 0.8)
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"-errorerrorerror--%@",error);
        }];
        
    }else if ([stryle isEqualToString:@"转账"]){
//       转账的推荐码：155413
//        http://39.108.151.95:8000/MyApp/user/giveMSB2Other/oEtQjv6WA4ODD9R-T9w_3IIZFWYc/1/155413

        NSString *url = [NSString stringWithFormat:@"http://39.108.151.95:8000/MyApp/user/giveMSB2Other/%@/%@/%@",self.resultDics[@"uid"],self.alertView.topTextF.text,self.alertView.bottomTextF.text];
        
        //检查地址中是否有中文
        NSString *urlStr = [NSURL URLWithString:url ] ? url : [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        AFHTTPSessionManager *manager=[self getAFManager];
        
        NSURLSessionTask *sessionTask=nil;
        
        sessionTask = [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
            
            if ([responseString isEqualToString:@"success"]) {
                Show_Toast(@"迈思币转账成功", 0.8)
                Custom_Weak(daiLiWeak)
                [daiLiWeak requestDaiLiMessage];
            }
            Show_Toast(@"迈思币转账失败", 0.8)
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    
    }
    
}
-(AFHTTPSessionManager *)getAFManager{
    
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=30;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"text/css",
                                                                              @"multipart/form-data",
                                                                              @"image/*"]];
    

    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            self.alertView.hidden = NO;
            self.alertView.isTiXian = YES;
        }else if (indexPath.row == 2){
            self.alertView.hidden = NO;
            self.alertView.isTiXian = NO;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 100;
    if (self.maiSiGuiZeDics.count >0) {
        height = [Common getHeightText:self.maiSiGuiZeDics[@"remarkValue"] WithWidth:(APP_Width-20) Font:13.f] + 24;
    }
    return indexPath.section == 3 ? height : 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(AlertView *)alertView{
    
    if (!_alertView) {
        _alertView = [AlertView nibFromXib];
        _alertView.frame = CGRectMake(0, 0, APP_Width, APP_Height);
        _alertView.delegate = self;
        [self.view addSubview:_alertView];
    }
    return _alertView;
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
