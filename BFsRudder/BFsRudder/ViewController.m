//
//  ViewController.m
//  BFsRudder
//
//  Created by 刘玲 on 2019/6/21.
//  Copyright © 2019年 BFs. All rights reserved.
//

#import "ViewController.h"
#import "BFsRudderView.h"

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
    
    BFsRudderView *rudder = [[BFsRudderView alloc] init];
    CGRect rudderFrame = CGRectMake(0, 0, 300.f, 300.f);
    [rudder setupFrame:rudderFrame];
    rudder.center = self.view.center;
    [self.view addSubview:rudder];
}

@end
