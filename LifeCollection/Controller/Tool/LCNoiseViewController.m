//
//  LCNoiseViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCNoiseViewController.h"
#import <AVFoundation/AVFoundation.h>

#define ZMScacle (w/288.f)
#define ZM_SPACE(x) ((x) * ZMScacle)

@implementation DrawRectView

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
    }
    return self;
}

- (void)show{
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zp"]];
    imageV.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:imageV];
    
    CALayer *needleLayer = [CALayer layer];
    needleLayer.anchorPoint = CGPointMake(0.5, (98-20)/98.f);
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    needleLayer.position = CGPointMake(w*0.5, (h-36)/2.f+36);
    needleLayer.bounds = CGRectMake(0, 0, ZM_SPACE(39.5), ZM_SPACE(98));
    needleLayer.contents = (id)[UIImage imageNamed:@"zz"].CGImage;
    [self.layer addSublayer:needleLayer];
    needleLayer.transform = CATransform3DMakeRotation(-0.75*M_PI, 0, 0, 1);
    _needleLayer = needleLayer;
}


@end


@interface LCNoiseViewController ()

@property (strong, nonatomic) UILabel *numberLb;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSTimer *levelTimer;
@property (strong, nonatomic) DrawRectView *rectView;

@end

@implementation LCNoiseViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_levelTimer && [_levelTimer isValid]) {
        
        [_levelTimer invalidate];
        _levelTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"噪音测试";
    self.view.backgroundColor = [LCColor colorWithR255:0 G255:99 B255:176 A255:255];
    [self createSubviews];
    
    [self testVoice];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.tintColor = [UIColor whiteColor];
    button.frame = CGRectMake(15, 35, 37, 37);
    [button setImage:[UIImage imageNamed:@"tool_fanhui_left"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)buttonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)testVoice{
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (_recorder)
    {
        [_recorder prepareToRecord];
        _recorder.meteringEnabled = YES;
        [_recorder record];
        _levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        NSLog(@"%@", [error description]);
    }
}

- (void)levelTimerCallback:(NSTimer *)timer {
    
    [_recorder updateMeters];
    float level;
    float minDecibels = -80.0f;
    float decibels = [_recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels){
        level = 0.0f;
    }else if (decibels >= 0.0f){
        level = 1.0f;
    }else{
        
        level =(1 - decibels/(float)minDecibels);
    }
    
    CGFloat theVal = level * 110;
    [_numberLb setText:[NSString stringWithFormat:@"%.0f",theVal]];
    [_numberLb setAttributedText:[self changeLabelWithText:[NSString stringWithFormat:@"%.0fdb",theVal]]];
    
    CGFloat angle = theVal/(float)110 * 1.5*M_PI;
    CGFloat needAngle = angle - 0.75*M_PI;
    
    _rectView.needleLayer.transform = CATransform3DMakeRotation(needAngle, 0, 0, 1);
}

- (void)createSubviews
{
    CGFloat imgHeight = ScreenWidth *604/375.f;
    UIImageView *baseImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight-imgHeight, ScreenWidth, imgHeight)];
    baseImgV.image = [UIImage imageNamed:@"cezao-bg"];
    [self.view addSubview:baseImgV];
    CGFloat width = 288.5*ScreenWidth/(288.5+86);
    CGFloat height = 248.5*ScreenWidth/(288.5+86);
    CGFloat x = (ScreenWidth - width)/2.f;
    CGFloat y = 30;
    _rectView = [[DrawRectView alloc]initWithFrame:CGRectMake(x, y+kStatesNavHeight, width, height)];
    [_rectView show];
    [self.view addSubview:_rectView];
    
    _numberLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_rectView.frame)-30, ScreenWidth, 45)];
    _numberLb.textAlignment = NSTextAlignmentCenter;
    _numberLb.font = [UIFont systemFontOfSize:45 weight:UIFontWeightMedium];
    _numberLb.backgroundColor = [UIColor clearColor];
    [_numberLb setAttributedText:[self changeLabelWithText:@"0db"]];
    _numberLb.textColor = [UIColor whiteColor];
    [self.view addSubview:_numberLb];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_numberLb.frame)+20, ScreenWidth, 18)];
    message.textAlignment = NSTextAlignmentCenter;
    message.backgroundColor = [UIColor clearColor];
    message.textColor = [UIColor whiteColor];
    message.text = @"当前的噪音";
    message.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.view addSubview:message];
}

- (NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(needText.length-2,2)];
    return attrString;
}

- (void)dealloc{
    
    _recorder = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

