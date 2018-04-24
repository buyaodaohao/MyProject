//
//  PersonCenterVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/22.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "PersonCenterVC.h"
#import "JiHuoVIPVC.h"
#import "DaiLiVC.h"

#import "UserMessageModel.h"

#import "UMSocialWechatHandler.h"
#import "PersonOtherCell.h"
#import "PersonCenterCell.h"


@interface PersonCenterVC ()<UITableViewDelegate,UITableViewDataSource,JiHuoVIPVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *personTableView;
@property(strong,nonatomic)NSString * headerImageUrlStr;
@property(strong,nonatomic)NSString * WX_UidStr;

@end

@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户中心";

    [self.personTableView registerNib:[UINib nibWithNibName:@"PersonOtherCell" bundle:nil] forCellReuseIdentifier:@"PersonOtherCell"];
    [self.personTableView registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"PersonCenterCell"];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.WX_UidStr = User_Default_ObjectForKey(@"WX_Uid");
    if (indexPath.section == 3) {
        if (self.WX_UidStr.length == 0) {
            [self WXLoginWithContentVC:@"代理"];
        }else{
            DaiLiVC * vc = [[DaiLiVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 0){
        if (self.WX_UidStr.length == 0) {
            [self WXLoginWithContentVC:@""];
        }
    }else if (indexPath.section==1){
        if (indexPath.row == 0) {
            if (self.WX_UidStr.length == 0) {
                [self WXLoginWithContentVC:@"激活VIP"];
            }else{
                JiHuoVIPVC * vc = [[JiHuoVIPVC alloc]init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
}
-(void)WXLoginWithContentVC:(NSString *)contentVC{
    
    Custom_Weak(WXWeak)
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (userinfo.uid != nil) {
            Show_Toast(@"用户登录成功", 1.3)
            User_Default_SetObjectForKey(userinfo.uid, @"WX_Uid")
            User_Default_SetObjectForKey(userinfo.iconurl, @"WX_Header_Url")
            User_Default_SetObjectForKey(userinfo.name, @"WX_Name")
            [WXWeak loginVCWithUserId:userinfo.uid isContentVC:contentVC];
        
        }else{
            Show_Toast(@"微信登录失败", 0.8)
        }
        
    }];
}
#pragma mark--支付成功，刷新天数
-(void)JiHuoVIPVCDelegateWithPaySuccess{

    [self loginVCWithUserId:User_Default_ObjectForKey(@"WX_Uid") isContentVC:@""];
}
-(void)loginVCWithUserId:(NSString *)uid isContentVC:(NSString *)contentVC{
    
    Custom_Weak(loginWeak)
    [ServiceTool getBaseWithUrl:[NSString stringWithFormat:@"http://39.108.151.95:8000/MyApp/user/getUser/%@",uid] Params:nil ShowHUD:YES success:^(id results) {
        
        User_Default_SetObjectForKey(results[@"uid"], @"uid")
        User_Default_SetObjectForKey(results[@"vipLeft"], @"vipLeft")
        User_Default_SetObjectForKey(results[@"pointsLeft"], @"pointsLeft")
        User_Default_SetObjectForKey(results[@"commendLeft"], @"commendLeft")
        User_Default_SetObjectForKey(results[@"commendNo"], @"commendNo")
        User_Default_SetObjectForKey(results[@"ifFirst"], @"ifFirst")
        User_Default_SetObjectForKey(results[@"giveAmount"], @"giveAmount")
        User_Default_SetObjectForKey(results[@"private"], @"private")
        [loginWeak.personTableView reloadData];
        if ([contentVC isEqualToString:@"激活VIP"]) {
            JiHuoVIPVC * vc = [[JiHuoVIPVC alloc]init];
            vc.delegate = loginWeak;
            [loginWeak.navigationController pushViewController:vc animated:YES];
        }else if([contentVC isEqualToString:@"代理"]) {
            
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error-----%@",error);
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 1 ?2:1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        PersonCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCenterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    PersonOtherCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonOtherCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.isDaiLiViewController = YES;
    cell.currentIndex = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.section == 0 ? 80 : 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
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
