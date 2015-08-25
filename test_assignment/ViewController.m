//
//  ViewController.m
//  test_assignment
//
//  Created by mac on 8/24/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_Method:(id)sender {
    [self performSegueWithIdentifier:@"CustomerTableView" sender:self];
}
@end
