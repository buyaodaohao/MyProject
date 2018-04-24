//
//  MySetViewController.m
//  OneHundredThousand
//
//  Created by SY-iMAC-001 on 2018/4/24.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)235 / 255 green:(CGFloat)235 / 255 blue:(CGFloat)235 / 255 alpha:1.0];
    [self addTopNaviBarWithTitle:@"设置"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:(CGFloat)235 / 255 green:(CGFloat)235 / 255 blue:(CGFloat)235 / 255 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark -- 设置导航栏
-(void)addTopNaviBarWithTitle:(NSString *)titleStr
{
    UIView *naviBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    UIColor *naviColor = [UIColor colorWithRed:(CGFloat)248/255 green:(CGFloat)34/255 blue:(CGFloat)76/255 alpha:1.0];
    naviBar.backgroundColor = naviColor;
    if(titleStr.length)
        {
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40.0 - 40.0, 132.0 / 3.0)];
        
        titleLabel.font = FONT_SIZE_16;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        [titleLabel setCenter:CGPointMake(naviBar.center.x, naviBar.center.y + SCREEN_Y / 2.0)];
        [naviBar addSubview:titleLabel];
        titleLabel.hidden = NO;
        titleLabel.text = titleStr;
        }else{
            
        }
    CGSize needSize = [@"返回" boundingRectWithSize:CGSizeMake(200, 44.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : FONT_SIZE_16} context:nil].size;
    UIButton *backBottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_Y, 36.0 / 3.0 + 66.0 / 3.0 + needSize.width + 4.0, 44)];
    backBottomBtn.backgroundColor = [UIColor clearColor];
    [backBottomBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backBottomBtn];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(36.0 / 3.0,SCREEN_Y+ (44.0 - 66.0 / 3.0) / 2.0, 66.0 / 3.0, 66.0 / 3.0)];
    
    [backButton setImage:[UIImage imageNamed:@"left-arrow-white-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backButton];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(backButton.frame.origin.x + backButton.frame.size.width, SCREEN_Y, needSize.width + 2.0, 44.0)];
    backLabel.textAlignment = NSTextAlignmentLeft;
    backLabel.text = @"返回";
    backLabel.font = FONT_SIZE_16;
    backLabel.textColor = [UIColor whiteColor];
    [naviBar addSubview:backLabel];
    [self.view addSubview:naviBar];
}
-(void)goBack
{
[self.navigationController popViewControllerAnimated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT_SIZE_14;
    cell.textLabel.textColor = [UIColor colorWithRed:(CGFloat)51 / 255 green:(CGFloat)51 / 255 blue:(CGFloat)51 / 255 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
            {
            cell.imageView.image = [UIImage imageNamed:@"cleaning_635.09131403118px_1161714_easyicon.net"];
            cell.textLabel.text = @"清除缓存";
            }
            break;
        case 1:
        {
        cell.imageView.image = [UIImage imageNamed:@"update_512px_1125846_easyicon.net"];
        cell.textLabel.text = @"检查更新";
        }
            break;
        case 2:
        {
        cell.imageView.image = [UIImage imageNamed:@"out_445px_1194507_easyicon.net"];
        cell.textLabel.text = @"退出登录";
        }
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34.0 / 3.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133.0 / 3.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
