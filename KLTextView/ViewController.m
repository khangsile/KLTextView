//
//  ViewController.m
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.textView setResizedViews:[NSMutableArray arrayWithObject:self.tableview]];
    [self.bar setResizeViews:[NSMutableArray arrayWithObject:self.tableview]];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect barFrame = self.bar.frame;
    barFrame.origin.y = window.frame.size.height - barFrame.size.height - 20;
    self.bar.frame = barFrame;
    
    CGRect frame = self.tableview.frame;
    frame.origin = CGPointMake(0, 0);
    frame.size.height = barFrame.origin.y - frame.origin.y;
    self.tableview.frame = frame;
    
    CGRect textFrame = self.textView.frame;
    textFrame.size.height = self.textView.contentSize.height;
    textFrame.origin.y = (self.bar.frame.size.height - textFrame.size.height) / 2.0;
    self.textView.frame = textFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
