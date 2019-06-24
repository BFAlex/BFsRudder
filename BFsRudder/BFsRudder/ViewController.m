//
//  ViewController.m
//  BFsRudder
//
//  Created by 刘玲 on 2019/6/21.
//  Copyright © 2019年 BFs. All rights reserved.
//

#import "ViewController.h"
#import "BFsRudderView.h"
#import "BFsRudderView2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testView];
}

#pragma mark -

- (void)testView {
    
    CGFloat viewWH = self.view.bounds.size.width - 16.f;
    
//    BFsRudderView *rudder = [[BFsRudderView alloc] init];
//    CGRect rudderFrame = CGRectMake(0, 0, viewWH, viewWH);
//    [rudder setupFrame:rudderFrame];
//    [self.view addSubview:rudder];
    
    BFsRudderView2 *rudder2 = [[BFsRudderView2 alloc] init];
    CGRect rudder2Frame = CGRectMake(0, 0, viewWH, viewWH);
    [rudder2 updateFrame:rudder2Frame];
    [self.view addSubview:rudder2];
    rudder2.center = self.view.center;
}

@end
