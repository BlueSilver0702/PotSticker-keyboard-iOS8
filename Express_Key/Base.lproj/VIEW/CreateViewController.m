//
//  CreateViewController.m
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "CreateViewController.h"
#import "AppDelegate.h"
#import "QuartzCore/QuartzCore.h"
#import "PackViewController.h"

@interface CreateViewController ()
{
    NSString *compoundTxt;
}

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.currentPack) {
        self.currentPack = [[PackModel alloc] init];
    }
    self.txtViewList = [[NSMutableArray alloc] initWithObjects:self.txtView, nil];
//    [self.txtViewList addObject:self.txtView];
    
    compoundTxt = @"";
    self.editText = @"";
    
    UIMenuController* menuController = [UIMenuController sharedMenuController];
    UIMenuItem* menuItem = [[UIMenuItem alloc] initWithTitle:@"Group Option" action:@selector(actionOfMenuItem:)];
    [menuController setMenuItems:@[menuItem]];
}

- (void)viewWillAppear:(BOOL)animated {
    if (YES) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please eneble Potsticker keyboard extension" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    CGRect frame = self.txtView.frame;
    frame.origin.y = 0;
    self.txtView.frame = frame;

    if (self.currentPack.packText.length) {
        self.txtView.text = self.currentPack.packText;
        [self refreshArea];
        [self.txtView becomeFirstResponder];
    }
}

- (void)viewDidAppear:(BOOL)animated {
//    [self.txtView becomeFirstResponder];
    [[self.txtViewList objectAtIndex:self.txtViewList.count-1] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewListPage:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)saveExpress:(id)sender {
    bool isEdit = NO;
    if (self.currentPack.packName.length) {
        isEdit = YES;
    }
    
//    NSLocale* currentLocale = [NSLocale currentLocale];
    
    if (!isEdit) {
        NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
        [dateformater setDateFormat:@"yyyyMMdd,HH:mm"];
        NSString *str = [dateformater stringFromDate: [NSDate date]];
        self.currentPack.packName = str;
    }
    
    NSString *editStr = @"";
    for (PackTextView *iTextView in self.txtViewList) {
        if (iTextView.isCompound) {
            editStr = [NSString stringWithFormat:@"%@<!--%@-->", editStr, iTextView.text];
        } else {
            editStr = [NSString stringWithFormat:@"%@%@", editStr, iTextView.text];
        }
    }
    self.currentPack.packText = editStr;

    NSMutableArray *updateArray = [[NSMutableArray alloc] initWithArray:gAppDelegate.gDataModel.packsArray];
    if (isEdit) {
        for (int i = 0; i < [updateArray count]; i++) {
            PackModel* contact = (PackModel*)[updateArray objectAtIndex:i];
            if (contact.packName == self.currentPack.packName) {
                [updateArray replaceObjectAtIndex:i withObject:self.currentPack];
            }
        }
        [gAppDelegate.gDataModel updateDB:updateArray];
    } else {
        [updateArray addObject:self.currentPack];
        [gAppDelegate.gDataModel updateDB:updateArray];
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PackViewController* vc = (PackViewController *)[storyboard instantiateViewControllerWithIdentifier:@"packID"];
    
    if (self.currentPack.packText.length) {
        if (isEdit) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You should insert expressions!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
    PackModel *model = [[PackModel alloc] init];
    model.packName = self.currentPack.packName;
    model.packText = self.currentPack.packText;
    vc.model = model;
//    vc.textView.text = self.currentPack.packText;
    
    //[gDataModel.contactsArray addObject:m_contactModel];
    
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alertView show];
    
}

- (void)autoResize {
    int top = 10;
    for (PackTextView *xtxtView in self.txtViewList) {
        CGRect frame = xtxtView.frame;
        frame.size.height = xtxtView.contentSize.height;
        frame.origin.y = top;
        xtxtView.frame = frame;
        top += frame.size.height;
//        xtxtView.backgroundColor = [UIColor redColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.currentTxtView = (PackTextView *)textView;
    self.currentTxtView.isCurrent = YES;
    
//    if ([self.currentTxtView.text isEqualToString:@"\u200B"] && self.currentTxtView.isCompound) {
//    
//    }
    [self autoResize];
}

- (void)actionOfMenuItem:(id)sender
{
    NSRange range = [self.currentTxtView selectedRange];
    NSString *str = [self.txtView.text substringWithRange:range];
    NSString *strPre = [self.txtView.text substringToIndex:range.location];
    NSString *strAft = [self.txtView.text substringFromIndex:range.location+range.length];
    self.editText = [NSString stringWithFormat:@"%@%@<!--%@-->%@", self.editText, strPre, str, strAft];
    self.currentTxtView.isCompound = YES;
    
    [self refreshArea];
}

- (void)refreshArea {
    NSString *editStr = @"";
    for (PackTextView *iTextView in self.txtViewList) {
        if (iTextView.text.length == 0) {
            [iTextView removeFromSuperview];
        }
        if (iTextView.isCurrent) {
            if (editStr.length)
                editStr = [NSString stringWithFormat:@"%@%@", editStr, self.editText];
            else
                editStr = [NSString stringWithFormat:@"%@", self.editText];
        } else {
            if (editStr.length)
                editStr = [NSString stringWithFormat:@"%@%@", editStr, iTextView.text];
            else
                editStr = [NSString stringWithFormat:@"%@", iTextView.text];
        }
        [iTextView removeFromSuperview];
        [self.txtViewList removeAllObjects];
    }
    [self pharseTxt:editStr];
    for (PackTextView *jTextView in self.txtViewList) {
        if (jTextView.isCompound) {
            jTextView.backgroundColor = [UIColor colorWithRed:209/255.0 green:238/255.0 blue:252/255.0 alpha:1.0];
            jTextView.layer.cornerRadius = 5;
            jTextView.clipsToBounds = YES;
            jTextView.textAlignment = NSTextAlignmentCenter;
        } else {
            jTextView.backgroundColor = [UIColor clearColor];
        }
        
        jTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
        [self.containView addSubview:jTextView];
    }
    [self autoResize];
}

- (void) pharseTxt:(NSString *)str {
    NSUInteger length = [str length];
    NSUInteger sublength = 0;
    NSRange range = NSMakeRange(0, length);
    NSString *tmpStr = @"";
    CGRect rect = self.containView.frame;
    rect.size.height = 45.0;
    rect.origin.x = 0;
    
    int i = 0;

    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @"<!--" options:0 range:range];
        if(range.location != NSNotFound)
        {
            i++;
            PackTextView *tmpView = [[PackTextView alloc] initWithFrame:rect];
            tmpView.delegate = self;
            tmpView.text = [str substringToIndex:range.location];
            NSLog(@"1--------%@", tmpView.text);
            sublength = tmpView.text.length+4;
            [self.txtViewList addObject:tmpView];
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            
            range = [str rangeOfString: @"-->" options:0 range:range];
            if(range.location != NSNotFound)
            {
                PackTextView *tmpView1 = [[PackTextView alloc] initWithFrame:rect];
                tmpView1.delegate = self;
                tmpView1.text = [str substringToIndex:range.location];
                tmpView1.text = [tmpView1.text substringFromIndex:sublength];
                NSLog(@"2------%@:%@", tmpView1.text, str);
                tmpView1.isCompound = YES;
                [self.txtViewList addObject:tmpView1];
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                tmpStr = [str substringFromIndex:range.location];
            }
        } else {
            PackTextView *tmpView = [[PackTextView alloc] initWithFrame:rect];
            tmpView.delegate = self;
            NSLog(@"%@---%@------.......",str, tmpView.text);
            if (i) {
                tmpView.text = tmpStr;
            } else {
                tmpView.text = str;
            }
            
            [self.txtViewList addObject:tmpView];
        }
    }
    [self autoResize];
}

//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    [textView.text enumerateSubstringsInRange:NSMakeRange(0, [textView.text length]) options:NSStringEnumerationLocalized usingBlock:^(NSString* word, NSRange wordRange, NSRange enclosingRange, BOOL* stop) {
//        NSRange range = [self.txtView selectedRange];
//        NSString *str = [self.txtView.text substringWithRange:range];
//
//        compoundTxt = str;
//    }];
//}


@end
