//
//  StartFigureManager.m
//  LifeCollection
//
//  Created by gozap on 2018/12/26.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "StartFigureManager.h"
#import "LCWebViewViewController.h"

/** 以下连接供测试使用 */

/** 静态图 */
#define imageURL1 @"http://yun.it7090.com/image/XHLaunchAd/pic_test01.jpg"

/** 动态图 */
#define imageURL3 @"http://yun.it7090.com/image/XHLaunchAd/gif_test01.gif"

/** 视频链接 */
#define videoURL1 @"http://yun.it7090.com/video/XHLaunchAd/video_test01.mp4"

@implementation StartFigureManager

+(void)load{
    [self shareManager];
}

+(StartFigureManager *)shareManager{
    static StartFigureManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[StartFigureManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}

-(void)setupXHLaunchAd{
    
    /** 1.图片开屏广告 - 网络数据 */
    //[self example01];
    
    //2.******图片开屏广告 - 本地数据******
    [self example02];
    
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
    //广告数据请求
//    [Network getLaunchAdImageDataSuccess:^(NSDictionary * response) {
//        NSLog(@"广告数据 = %@",response);
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//        //广告停留时间
//        imageAdconfiguration.duration = model.duration;
//        //广告frame
//        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
//        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//        imageAdconfiguration.imageNameOrURLString = model.content;
//        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//        imageAdconfiguration.GIFImageCycleOnce = NO;
//        //缓存机制(仅对网络图片有效)
//        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//        //图片填充模式
//        imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
//        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        imageAdconfiguration.openModel = model.openUrl;
//        //广告显示完成动画
//        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
//        //广告显示完成动画时间
//        imageAdconfiguration.showFinishAnimateTime = 0.8;
//        //跳过按钮类型
//        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//        //后台返回时,是否显示广告
//        imageAdconfiguration.showEnterForeground = NO;
//
//        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
//        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
//            //设置要添加的自定义视图(可选)
//            imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//
//        }
//        //显示开屏广告
//        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//
//    } failure:^(NSError *error) {
//    }];
    
}

#pragma mark - 图片开屏广告-本地数据-示例
//图片开屏广告 - 本地数据
-(void)example02{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image12.gif";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.xzzai.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeRoundProgressText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
}

#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = XH_FULLSCREEN ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel==nil) return;
    
    LCWebViewViewController *VC = [[LCWebViewViewController alloc] init];
    NSString *urlString = (NSString *)openModel;
    VC.urlStr = urlString;
    //此处不要直接取keyWindow
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.navigationController pushViewController:VC animated:YES];
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

@end
