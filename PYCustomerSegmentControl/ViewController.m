//
//  ViewController.m
//  PYCustomerSegmentControl
//
//  Created by ZpyZp on 15/12/1.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import "ViewController.h"
#import "PYSegmentControl.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PYSegmentControl *segmentControl = [[PYSegmentControl alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width-20, 50)];
    segmentControl.textArray = @[@"Contacts",@"Invite",@"Search",@"我擦"];
    [self.view addSubview:segmentControl];
    [segmentControl setBlockCallBack:^(NSInteger index, NSString *title) {
        NSLog(@"%d-%@",index,title);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
