//
//  AliPayVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2018/1/8.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import "AliPayVC.h"

#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobQuery.h>
@interface AliPayVC ()

@end

@implementation AliPayVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = Gray_View_COLOR;

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Alipay_ID"];
    //        获得某个表中的所有数据
    //查找Alipay_ID表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"cbf4efbca0" block:^(BmobObject *object,NSError *error){
        if (error){
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                NSString * resultStr = [object objectForKey:@"Alipay_ID"];
                if (resultStr.length >3) {
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = resultStr;
                }
               
            }
        }
    }];

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
