//
//  ViewController.h
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLKeyBoardbar.h"
#import "KLTextView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet KLKeyboardBar *bar;
@property (nonatomic, strong) IBOutlet KLTextView *textView;
@property (nonatomic, strong) IBOutlet UIView *tableview;

@end
