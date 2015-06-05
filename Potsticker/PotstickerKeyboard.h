//
//  PotstickerKeyboard.h
//  Express_Key
//
//  Created by Jan on 28/10/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PotstickerKeyboard : UIView

@property(strong, nonatomic) IBOutlet UIView *containView;
@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic) NSMutableArray *packArr;

-(IBAction)onOtherKeyboard:(id)sender;
-(IBAction)onHelpPage:(id)sender;
-(IBAction)onSpace:(id)sender;
-(IBAction)onReturn:(id)sender;
-(IBAction)onDelete:(id)sender;
- (id)init:(UIInputViewController*)inputViewController;

@end
