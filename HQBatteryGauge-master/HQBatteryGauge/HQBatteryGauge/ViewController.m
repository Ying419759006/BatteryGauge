//
//  ViewController.m
//  HQBatteryGauge
//
//  Created by zhaoy on 2017/7/19.
//  Copyright © 2017年 zhaoy. All rights reserved.
//

#import "ViewController.h"

//Battery Gauge 1
#define BatteryGauge1PosX [UIScreen mainScreen].bounds.size.width/2
#define BatteryGauge1PosY 180
#define BatteryGauge1Width [UIScreen mainScreen].bounds.size.width*0.7
#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees) ((pi * degrees)/ 180)

//Battery Gauge 2
#define BatteryGauge2Width [UIScreen mainScreen].bounds.size.width*0.4
#define BatteryGauge2PosX [UIScreen mainScreen].bounds.size.width/2-BatteryGauge2Width/2
#define BatteryGauge2PosY 250

@interface ViewController ()

@property (nonatomic) int BatteryLifeNumber;
@property (nonatomic) int CurrentBatteryLifeNumber;
@property (nonatomic) int NewBatteryLifeNumber;
@property (nonatomic, strong) UILabel *BatteryLifeLabel;
@property (nonatomic, strong) UIView *BatteryLifeMark;
@property (nonatomic, strong) CAShapeLayer *arrowLayer;
@property (nonatomic, strong) NSTimer *UITimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set UI background color
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0f green:108/255.0f blue:115/255.0f alpha:1.0f];
    
    //set subView
    [self setSubViews];
    
}

- (void)setSubViews {
    //draw battery gauge 1 interface
    CAShapeLayer *markLayer1 = [CAShapeLayer layer];
    [markLayer1 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-17 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(198) clockwise:YES] CGPath]];
    [markLayer1 setStrokeColor:[[UIColor redColor] CGColor]];
    [markLayer1 setLineWidth:45];
    [markLayer1 setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:markLayer1];
    
    CAShapeLayer *markLayer2 = [CAShapeLayer layer];
    [markLayer2 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-17 startAngle:DEGREES_TO_RADIANS(342) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES] CGPath]];
    [markLayer2 setStrokeColor:[[UIColor redColor] CGColor]];
    [markLayer2 setLineWidth:45];
    [markLayer2 setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:markLayer2];
    
    CAShapeLayer *markLayer3 = [CAShapeLayer layer];
    [markLayer3 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-17 startAngle:DEGREES_TO_RADIANS(198) endAngle:DEGREES_TO_RADIANS(216) clockwise:YES] CGPath]];
    [markLayer3 setStrokeColor:[[UIColor yellowColor] CGColor]];
    [markLayer3 setLineWidth:45];
    [markLayer3 setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:markLayer3];
    
    CAShapeLayer *markLayer4 = [CAShapeLayer layer];
    [markLayer4 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-17 startAngle:DEGREES_TO_RADIANS(324) endAngle:DEGREES_TO_RADIANS(342) clockwise:YES] CGPath]];
    [markLayer4 setStrokeColor:[[UIColor yellowColor] CGColor]];
    [markLayer4 setLineWidth:45];
    [markLayer4 setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:markLayer4];
    
    CAShapeLayer *markLayer5 = [CAShapeLayer layer];
    [markLayer5 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-17 startAngle:DEGREES_TO_RADIANS(216) endAngle:DEGREES_TO_RADIANS(324) clockwise:YES] CGPath]];
    [markLayer5 setStrokeColor:[[UIColor greenColor] CGColor]];
    [markLayer5 setLineWidth:45];
    [markLayer5 setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:markLayer5];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY) radius:BatteryGauge1Width/2-37 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES] CGPath]];
    [circleLayer setStrokeColor:[[UIColor grayColor] CGColor]];
    [circleLayer setLineWidth:10];
    [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    [[self.view layer] addSublayer:circleLayer];
    
    _arrowLayer = [CAShapeLayer layer];
    _arrowLayer.frame = CGRectMake(BatteryGauge1PosX, BatteryGauge1PosY, 0, 0);
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint:CGPointMake(0-BatteryGauge1Width/2-15, 0)];
    _arrowLayer.path=linePath.CGPath;
    _arrowLayer.fillColor = nil;
    _arrowLayer.lineWidth = 4;
    _arrowLayer.opacity = 4;
    _arrowLayer.strokeColor = [[UIColor blackColor] CGColor];
    [[self.view layer] addSublayer:_arrowLayer];
    
    CAShapeLayer *circleLayer2 = [CAShapeLayer layer];
    [circleLayer2 setPath:[[UIBezierPath bezierPathWithArcCenter:CGPointMake(BatteryGauge1PosX, BatteryGauge1PosY+2) radius:BatteryGauge1Width/2-46 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES] CGPath]];
    [circleLayer2 setFillColor:[[UIColor colorWithRed:48/255.0f green:108/255.0f blue:115/255.0f alpha:1.0f] CGColor]];
    [[self.view layer] addSublayer:circleLayer2];
    
    //initialize battery life value with 0
    _BatteryLifeNumber = 0;
    
    //draw the battery life value
    _BatteryLifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(BatteryGauge1PosX-6, BatteryGauge1PosY-15, 300, 30)];
    _BatteryLifeLabel.text = [NSString stringWithFormat:@"%d", _BatteryLifeNumber];
    _BatteryLifeLabel.textColor = [UIColor whiteColor];
    _BatteryLifeLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0];
    [self.view addSubview:_BatteryLifeLabel];
    
    //draw battery gauge 2 interface
    CAShapeLayer *battery2Layer = [CAShapeLayer layer];
    battery2Layer.frame = CGRectMake(BatteryGauge2PosX, BatteryGauge2PosY, 0, 0);
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint: CGPointMake(0, 0)];
    [linePath2 addLineToPoint:CGPointMake(BatteryGauge2Width, 0)];
    [linePath2 addLineToPoint:CGPointMake(BatteryGauge2Width, BatteryGauge2Width/3)];
    [linePath2 addLineToPoint:CGPointMake(0, BatteryGauge2Width/3)];
    [linePath2 addLineToPoint:CGPointMake(0, 0)];
    [linePath2 moveToPoint: CGPointMake(BatteryGauge2Width, BatteryGauge2Width/8)];
    [linePath2 addLineToPoint:CGPointMake(BatteryGauge2Width+5, BatteryGauge2Width/8)];
    [linePath2 addLineToPoint:CGPointMake(BatteryGauge2Width+5, BatteryGauge2Width/5)];
    [linePath2 addLineToPoint:CGPointMake(BatteryGauge2Width, BatteryGauge2Width/5)];
    battery2Layer.path = linePath2.CGPath;
    battery2Layer.fillColor = nil;
    battery2Layer.lineWidth = 1;
    battery2Layer.opacity = 4;
    battery2Layer.strokeColor = [[UIColor whiteColor] CGColor];
    [[self.view layer] addSublayer:battery2Layer];
    
    //draw the battery life mark for battery gauge 2
    _BatteryLifeMark = [[UIView alloc] initWithFrame:CGRectMake(BatteryGauge2PosX+2, BatteryGauge2PosY+2, 0, BatteryGauge2Width/3-4)];
    _BatteryLifeMark.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_BatteryLifeMark];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Set Battery Life" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(setBatteryLife:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setBatteryLife:(UIButton *)sender {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"Set Battery Life" message:@"Please Enter a number between 0 to 100" preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CGFloat count = [alertControl.textFields.firstObject.text floatValue];
        if (0 <= count && count <= 100) {
            NSLog(@"%f", count);
            _NewBatteryLifeNumber = count;
            _CurrentBatteryLifeNumber = _BatteryLifeNumber;
            //start the animation of battery gauge 1 text change
            self.UITimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(BatteryLifeNumberChange) userInfo:nil repeats: YES];
            //start the animation of battery gauge 1 arraw rotation
            [self BatteryLifeArrowChange];
            //start the animation of battery gauge 2 mark change
            [self BatteryLifeMarkChange];
            _BatteryLifeNumber = _NewBatteryLifeNumber;
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入不合法" message:@"Please Enter a number between 0 to 100" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:OKAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:setAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)BatteryLifeNumberChange{
    if(_CurrentBatteryLifeNumber<_NewBatteryLifeNumber){
        _CurrentBatteryLifeNumber++;
        _BatteryLifeLabel.text = [NSString stringWithFormat:@"%d", _CurrentBatteryLifeNumber];
    }
    else if(_CurrentBatteryLifeNumber>_NewBatteryLifeNumber){
        _CurrentBatteryLifeNumber--;
        _BatteryLifeLabel.text = [NSString stringWithFormat:@"%d", _CurrentBatteryLifeNumber];
    }
    else{
        [_UITimer invalidate];
    }
}

- (void)BatteryLifeArrowChange{
    //calculate the angle of the arrow change
    int angle = _NewBatteryLifeNumber*1.8;
    int angle2 = (_NewBatteryLifeNumber-_BatteryLifeNumber)*1.8;
    //calculate the time of the animation
    int time = fabs((_NewBatteryLifeNumber-_BatteryLifeNumber)*0.1);
    
    //rotate the arrow
    _arrowLayer.transform = CATransform3DRotate(_arrowLayer.transform, DEGREES_TO_RADIANS(angle2), 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = time;
    animation.fromValue = @(DEGREES_TO_RADIANS(_BatteryLifeNumber*1.8));
    animation.toValue = @(DEGREES_TO_RADIANS(angle));
    //animation.removedOnCompletion = NO;
    //animation.fillMode = kCAFillModeForwards;
    [self.arrowLayer addAnimation:animation forKey:@"rotateAnimation"];
}

- (void)BatteryLifeMarkChange{
    //calculate the length of the mark change
    int length = _NewBatteryLifeNumber*(BatteryGauge2Width-4)/100;
    //calculate the time of the animation
    int time = fabs((_NewBatteryLifeNumber-_BatteryLifeNumber)*0.1);
    
    [UIView animateWithDuration:time animations:^{
        _BatteryLifeMark.frame = CGRectMake(BatteryGauge2PosX+2, BatteryGauge2PosY+2, length, BatteryGauge2Width/3-4);
    }completion:nil];
}

//set to white status bar
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
