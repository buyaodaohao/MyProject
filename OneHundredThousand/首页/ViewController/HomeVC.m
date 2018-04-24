//
//  HomeVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "HomeVC.h"
#import "DaiLiVC.h"
#import "MoreWebVC.h"
#import "VideoWebVC.h"

#import "HomeTopCell.h"
#import "HomeCenterCell.h"
#import "HomeBottomCell.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,HomeCenterCellDelegate,HomeBottomCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableV;
@property(strong,nonatomic)NSString * WX_UidStr;
@property(strong,nonatomic)NSMutableArray * imageUrlArrays;
@property(strong,nonatomic)NSMutableArray * messageGuangGaoArrays;

@end

@implementation HomeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"迈思影视";

    [self.homeTableV registerNib:[UINib nibWithNibName:@"HomeTopCell" bundle:nil] forCellReuseIdentifier:@"HomeTopCell"];
    [self.homeTableV registerNib:[UINib nibWithNibName:@"HomeCenterCell" bundle:nil] forCellReuseIdentifier:@"HomeCenterCell"];
    [self.homeTableV registerNib:[UINib nibWithNibName:@"HomeBottomCell" bundle:nil] forCellReuseIdentifier:@"HomeBottomCell"];
    self.imageUrlArrays = [[NSMutableArray alloc]init];
    self.messageGuangGaoArrays = [[NSMutableArray alloc]init];
    
    [self banner];
    [self messageGuangGao];
    self.WX_UidStr = User_Default_ObjectForKey(@"WX_Uid");
    if (self.WX_UidStr.length != 0) {
        [self loginVCWithUserId:self.WX_UidStr IsTuiJian:NO];
    }
   
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = @"yvaTTt561H";
//    NSLog(@"\n====>输入框内容为:\n====>剪切板内容为:%@",pasteboard.string);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 2 ? 2:1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomeTopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTopCell" forIndexPath:indexPath];
        if (self.imageUrlArrays.count >0) {
            cell.imageUrlArrays = self.imageUrlArrays;
        }
        if (self.messageGuangGaoArrays.count >0) {
            cell.messageArrays = self.messageGuangGaoArrays;
        }
        return cell;
        
    }else if (indexPath.section == 1) {
        HomeCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCenterCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row == 0) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"热门推荐";
        cell.detailTextLabel.text = @"更多分类";
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16.f];
        cell.detailTextLabel.textColor = Gray_Text_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    HomeBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBottomCell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}
#pragma mark--点击进入视频网站
-(void)HomeBottomCellDelegateSelectButtonWithText:(NSString *)text{
    
    NSString * days = User_Default_ObjectForKey(@"vipLeft");
    if ([days floatValue] <= 0.0) {
        Show_Toast(@"请充值VIP", 0.8)
        return;
    }
     VideoWebVC * vc = [[VideoWebVC alloc]init];
     vc.titleStr = text;
    if ([text containsString:@"腾讯视频"]) {
        vc.urlStr = @"https://v.qq.com/";
    }else if ([text containsString:@"爱奇艺"]) {
        vc.urlStr = @"http://www.iqiyi.com";
    }else if ([text containsString:@"优酷视频"]) {
        vc.urlStr = @"http://www.youku.com/";
    }else if ([text containsString:@"乐视视频"]) {
        vc.urlStr = @"http://www.le.com/";
    }else if ([text containsString:@"芒果TV"]) {
        vc.urlStr = @"http://www.mgtv.com/vip/";
    }else if ([text containsString:@"PPTV"]) {
        vc.urlStr = @"http://www.pptv.com/";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)homeCenterCellDelegateBtClickWithText:(NSString *)buttonText{
    
    if ([buttonText isEqualToString:@"推荐赚钱"]) {
        if (self.WX_UidStr.length != 0) {
            [self WXLogin];
        }else{
            DaiLiVC * vc = [[DaiLiVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)messageGuangGao{
    
//    http://39.108.151.95:8000/MyApp/user/getDicByGroup/38
    
    Custom_Weak(gungGaoWeak)
    [ServiceTool getBaseWithUrl:@"http://39.108.151.95:8000/MyApp/user/getDicByGroup/38" Params:nil ShowHUD:NO success:^(id results) {
        
        
        NSString * topMessageStr = results[0][@"value1"];
        
        
        NSString * bottomMessageStr = [NSString stringWithFormat:@"%@",results[0][@"value2"]];
        if (topMessageStr.length > 0) {
            [gungGaoWeak.messageGuangGaoArrays addObject:topMessageStr];
        }
        if (bottomMessageStr.length > 0 && ![bottomMessageStr isEqualToString:@"<null>"]) {
            [gungGaoWeak.messageGuangGaoArrays addObject:bottomMessageStr];
        }

        [gungGaoWeak.homeTableV reloadData];
        
    } fail:^(NSError *error) {
    }];
}
-(void)banner{
   
    Custom_Weak(bannerWeak)
    //    http://39.108.151.95:8000/MyApp/user/getDicByGroup/8
    [ServiceTool getBaseWithUrl:@"http://39.108.151.95:8000/MyApp/user/getDicByGroup/8" Params:nil ShowHUD:NO success:^(id results) {
       
        NSArray * resultArray = (NSArray *)results;
        for (int i = 0; i< resultArray.count; i++) {
            
            [bannerWeak.imageUrlArrays addObject:[NSString stringWithFormat:@"http://39.108.151.95:8000/MyApp%@",resultArray[i][@"value1"]]];
        }
        [bannerWeak.homeTableV reloadData];

    } fail:^(NSError *error) {
    }];
    
}
-(void)WXLogin{
    
    Custom_Weak(WXWeak)
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (userinfo.uid != nil) {
            Show_Toast(@"登录成功", 1.3)
            User_Default_SetObjectForKey(userinfo.uid, @"WX_Uid")
            User_Default_SetObjectForKey(userinfo.iconurl, @"WX_Header_Url")
            User_Default_SetObjectForKey(userinfo.name, @"WX_Name")
            [WXWeak loginVCWithUserId:userinfo.uid IsTuiJian:YES];
 
        }else{
            Show_Toast(@"用户微信登录失败", 0.8)
        }
        
    }];
}
-(void)loginVCWithUserId:(NSString *)uid IsTuiJian:(BOOL)isTuiJian{
    
    //    http://39.108.151.95:8000/MyApp/user/getUser/oEtQjv6WA4ODD9R-T9w_3IIZFWYc
    [ServiceTool getBaseWithUrl:[NSString stringWithFormat:@"http://39.108.151.95:8000/MyApp/user/getUser/%@",uid] Params:nil ShowHUD:YES success:^(id results) {

        User_Default_SetObjectForKey(results[@"uid"], @"uid")
        User_Default_SetObjectForKey(results[@"vipLeft"], @"vipLeft")
        User_Default_SetObjectForKey(results[@"pointsLeft"], @"pointsLeft")
        User_Default_SetObjectForKey(results[@"commendLeft"], @"commendLeft")
        User_Default_SetObjectForKey(results[@"commendNo"], @"commendNo")
        User_Default_SetObjectForKey(results[@"ifFirst"], @"ifFirst")
        User_Default_SetObjectForKey(results[@"giveAmount"], @"giveAmount")
        User_Default_SetObjectForKey(results[@"commend2cash"], @"commend2cash")
    
        
        if (isTuiJian) {
            DaiLiVC * vc = [[DaiLiVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:^(NSError *error) {
        NSLog(@"error-----%@",error);
    }];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        MoreWebVC * vc = [[MoreWebVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 270;
    }else if (indexPath.section == 1) {
        return 81;
    }
    if (indexPath.row == 0) {
        return 44;
    }
    return 390*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.01:10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
