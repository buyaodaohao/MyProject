

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}NetworkStatus;

typedef void( ^ WGResponseSuccess)(id response);
typedef void( ^ WGResponseFail)(NSError *error);

typedef void( ^ WGDownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask WGURLSessionTask;


@interface BaseService : NSObject
/**
 *  单例
 * */
+ (BaseService *)sharedWGNetworking;

/**
 *  获取网络
 */
@property (nonatomic,assign)NetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(WGURLSessionTask *)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(WGResponseSuccess)success fail:(WGResponseFail)fail showHUD:(BOOL)showHUD;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(WGURLSessionTask *)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(WGResponseSuccess)success fail:(WGResponseFail)fail showHUD:(BOOL)showHUD;

/**
 *  下载文件方法
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (WGURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(WGDownloadProgress )progressBlock success:(WGResponseSuccess )success failure:(WGResponseFail )fail showHUD:(BOOL)showHUD;

@end
