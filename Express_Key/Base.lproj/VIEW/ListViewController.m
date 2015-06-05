//
//  ListViewController.m
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "PackModel.h"
#import "CreateViewController.h"
#import "PackViewController.h"

@interface ListViewController ()
{
    int selectedIndexPath;
}

@property(nonatomic, weak)NSMutableArray *csvData;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [gAppDelegate refreshData];

//    NSLog(@"count:%d", [gAppDelegate.gPackList count]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [gAppDelegate refreshData];
    [self.listTable reloadData];
}

// -------------   tableView ---------
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gAppDelegate.gPackList count] + [self.csvData count];
//    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    return 44;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //We only don't want to allow selection on any cells which cannot be expanded
//    [self goEditContact:[m_arrayContactsList objectAtIndex: [indexPath row]]];
    return indexPath;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    
//    CreateViewController *newView = [[CreateViewController alloc] initWithId:indexPath.row];
//    [self.navigationController pushViewController:newView animated:YES];
    
    [self  performSegueWithIdentifier:@"PackViewVC" sender:indexPath];
    
//    [gAppDelegate.gPackList objectAtIndex:indexPath.row];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    PackModel *model = (PackModel *)[gAppDelegate.gPackList objectAtIndex:indexPath.row];
    cell.textLabel.text = [self filterCellContent: model.packText];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    UILongPressGestureRecognizer * gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longguesterAction:)];
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:gesture];
    
    return cell;
}

-(void) longguesterAction:(UIGestureRecognizer * ) recog
{
    UITableViewCell * cell = (UITableViewCell *) recog.view;
    NSLog(@"%ld", (long)cell.tag);
    
    if(recog.state == UIGestureRecognizerStateBegan)
    {
        selectedIndexPath = (int)cell.tag;
        [self.listTable setEditing:YES animated:YES];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PackViewVC"])
    {
        PackModel * model = [gAppDelegate.gPackList objectAtIndex:[(NSIndexPath *) sender row]];
        PackViewController * vc = [segue destinationViewController];
        vc.model = model;
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [gAppDelegate.gPackList removeObjectAtIndex:indexPath.row];
        [gAppDelegate.gDataModel updateDB:gAppDelegate.gPackList];
        [self.listTable setEditing:NO animated:YES];
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == selectedIndexPath)
        return YES;
    return NO;
    
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
//        UITableViewCell *cell = (UITableViewCell*)gestureRecognizer.view;
//        if (cell && [cell isKindOfClass:[UITableViewCell class]]) {
//            selectedIndexPath = [self.listTable indexPathForCell:cell];
//            [self.listTable setEditing:YES animated:YES];
//        }
//        NSLog(@"::::%d", selectedIndexPath.row);
//    }
//    return NO;
//}

-(NSString *) filterCellContent:(NSString *)content {
    NSString *retStr = @"";
    NSString *str = content;

    NSUInteger length = [str length];
    NSUInteger sublength = 0;
    NSRange range = NSMakeRange(0, length);
    NSString *tmpStr = @"";
    
    int i = 0;
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @"<!--" options:0 range:range];
        
        if(range.location != NSNotFound)
        {
            i++;
            retStr = [NSString stringWithFormat:@"%@%@", retStr, [str substringToIndex:range.location]];
            //            NSLog(@"1--------%@", tmpView.text);
            sublength = [str substringToIndex:range.location].length+4;

            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            
            range = [str rangeOfString: @"-->" options:0 range:range];
            if(range.location != NSNotFound)
            {
                retStr = [NSString stringWithFormat:@"%@%@", retStr, [[str substringToIndex:range.location] substringFromIndex:sublength]];
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                tmpStr = [str substringFromIndex:range.location];
            }
        } else {
            if (i) {
                retStr = [NSString stringWithFormat:@"%@%@", retStr, tmpStr];
            } else {
                retStr = content;
            }
        }
    }

    return retStr;
}


@end
