//
//  ViewController.m
//  TimeOfClock
//
//  Created by James on 1/26/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ViewController.h"
#import "JJWheelButton.h"
#define kAngle2Radian(angle) ((angle) * M_PI / 180.0)
#define kRandom4Color [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1]

@interface ViewController ()

/** 钟盘 */
@property (nonatomic, strong) CALayer *clockLayer;

/** 秒针 */
@property (nonatomic, weak) CALayer *secondLayer;

/** 分针 */
@property (nonatomic, weak) CALayer *minuteLayer;

/** 时针 */
@property (nonatomic, weak) CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view.layer addSublayer:self.clockLayer];
    //更新时间
    [self updateTime];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

/** 初始化钟盘 */
- (CALayer *)clockLayer {
    if (!_clockLayer) {
        CGFloat width = 250;
        CGPoint position = CGPointMake(width * 0.5, width * 0.5);
        _clockLayer = [CALayer layer];
        _clockLayer.bounds = CGRectMake(0, 0, width, width);
        _clockLayer.position = self.view.center;
        
        /****************	使用图图片   ****************/
        
//        _clockLayer.contents = (id)[UIImage imageNamed:@"12"].CGImage;
        
        /****************	使用按钮   ****************/
        
        [self constellation];
        
        
        
        self.secondLayer = [self layWithBounds:CGRectMake(0, 0, 2, 120) andPosition:position andBgColor:[UIColor redColor]];
        self.minuteLayer = [self layWithBounds:CGRectMake(0, 0, 4, 100) andPosition:position andBgColor:[UIColor blackColor]];
        self.hourLayer = [self layWithBounds:CGRectMake(0, 0, 6, 80) andPosition:position andBgColor:[UIColor blackColor]];
        
        CALayer *pointLayer = [self layWithBounds:CGRectMake(0, 0, 10, 10) andPosition:position andBgColor:[UIColor yellowColor]];
        pointLayer.cornerRadius = 5;
        pointLayer.masksToBounds = YES;
        pointLayer.borderWidth = 1;
        pointLayer.borderColor = [UIColor redColor].CGColor;
        pointLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _clockLayer;
}

/** 创建图层 */
- (CALayer *)layWithBounds:(CGRect)bounds andPosition:(CGPoint)position andBgColor:(UIColor *)bgColor {
    CALayer *layer = [CALayer layer];
    layer.bounds = bounds;
    layer.position = position;
    layer.anchorPoint = CGPointMake(0.5, 0.8);
    layer.backgroundColor = bgColor.CGColor;
    [_clockLayer addSublayer:layer];
    return layer;
}

/** 更新时间 */
- (void)updateTime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    self.secondLayer.transform = CATransform3DMakeRotation(kAngle2Radian(components.second * 6), 0, 0, 1);
    self.minuteLayer.transform = CATransform3DMakeRotation(kAngle2Radian(components.minute * 6), 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(kAngle2Radian(components.hour * 30 + components.minute / 60.0 * 30), 0, 0, 1);
}

/** 星座显示按钮 */
- (void)constellation {
    NSInteger btnCount = 12;
    CGFloat angle = M_PI / 6;
    UIImage *normalBigImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageWidth = normalBigImage.size.width / btnCount * scale;
    CGFloat imageHeight = normalBigImage.size.height * scale;
    for (NSInteger i = 0; i <btnCount; i++) {
        JJWheelButton *btn = [JJWheelButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, 50, 150);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.center = self.view.center;
        btn.transform = CGAffineTransformMakeRotation(angle * i);
        btn.backgroundColor = kRandom4Color;
        //获取图片
        CGRect imageRect = CGRectMake(imageWidth * i, 0, imageWidth, imageHeight);
        //剪切图片
        CGImageRef normalImageRef = CGImageCreateWithImageInRect(normalBigImage.CGImage, imageRect);
        [btn setImage:[UIImage imageWithCGImage:normalImageRef] forState:UIControlStateNormal];
        _clockLayer.contents = btn;
    }
}

@end
