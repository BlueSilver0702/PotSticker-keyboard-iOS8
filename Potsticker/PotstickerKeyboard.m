//
//  PotstickerKeyboard.m
//  Express_Key
//
//  Created by Jan on 28/10/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "PotstickerKeyboard.h"

UIInputViewController *theInputViewController;

@implementation PotstickerKeyboard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init:(UIInputViewController*)inputViewController
{
    theInputViewController = inputViewController;
    
    CGRect frame = inputViewController.view.frame;
    
    //	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    //	if(UIDeviceOrientationIsLandscape(orientation))
    //        frame = CGRectMake(0, 0, 480, 162);
    //    else {
    //        frame = CGRectMake(0, 0, 375, 216);
    //    }
    
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PotstickerKeyboard" owner:self options:nil];
        [[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
    }
    

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*1.9, self.scrollView.frame.size.height);
    
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:0];
    //    [buttons addObjectsFromArray:self.characterKeys];
    
    return self;
}

-(IBAction)onOtherKeyboard:(id)sender {
    
}
-(IBAction)onHelpPage:(id)sender {
    
}
-(IBAction)onSpace:(id)sender {
    
}
-(IBAction)onReturn:(id)sender {
    
}
-(IBAction)onDelete:(id)sender {
    
}

@end
