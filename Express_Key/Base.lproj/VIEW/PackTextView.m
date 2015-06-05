//
//  PackTextView.m
//  Express_Key
//
//  Created by Jan on 10/26/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "PackTextView.h"
#import "PackViewController.h"

@implementation PackTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.parentView) {
        [self.parentView touchPack];
    }
}

@end
