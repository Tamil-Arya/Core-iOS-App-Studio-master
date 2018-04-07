//
//  EDU_Group_List.m
//  ELAR
//
//  Created by Bhushan Bawa on 05/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "EDU_Group_List.h"
#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ImageCustomClass.h"
@interface EDU_Group_List ()

@end

@implementation EDU_Group_List

@synthesize values;
@synthesize Main_values;
@synthesize Sub_values;




-(void)Navigation_bar
{
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 //   UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];

    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    
    
    
    UIButton *Done = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Done setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] forState:UIControlStateNormal];
    
    [Done addTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    Done.frame = CGRectMake(0, 0, 50, 20);
    [Done setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *Done_btn = [[UIBarButtonItem alloc] initWithCustomView:Done];
    self.navigationItem.rightBarButtonItem = Done_btn;
    
    
    
}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self Navigation_bar];
    
    _cellSelected=[[NSMutableArray alloc]init];
    
    NSLog(@"%@",values);
    
    
    
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"NEWS_Select_List"]);
    
    check=false;
    
    check_values_tableview=false;
    
    get_id_Group=[[NSMutableArray alloc]init];
    
    get_id_type=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBarHidden=NO;
    
    mtable_view=[[UITableView alloc]init];
    mtable_view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mtable_view.delegate=self;
    mtable_view.dataSource=self;
    [self.view addSubview:mtable_view];
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(doneEditing)];

//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStylePlain target:self
//                                                                  action:@selector(doneEditing)];
//
//    [[self navigationItem] setRightBarButtonItem:doneButton];
    
}

- (void)doneEditing {
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"Publish_Updated_Draft" forKey:@"Publish_type"];
    }
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]);
    
    
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF!=%@ ",@""];
    NSArray*   myArray = [get_id_Group filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",myArray);
      
    
        [[NSNotificationCenter defaultCenter]
         postNotificationName:_notification
         object:myArray];
        
        [[NSUserDefaults standardUserDefaults]setObject:myArray forKey:@"EDU_Group_List"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
      [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[values valueForKey:@"groups"]valueForKey:@"name"]count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]==0 && check==false) {
        
        for (int tag=0;tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]; tag++) {
            
            
            if ([[[[values valueForKey:@"groups"]valueForKey:@"id"]objectAtIndex:indexPath.row] isEqualToString:[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]objectAtIndex:tag]]) {
                
                if (indexPath.row==0) {
                    check_values_tableview=true;
                }
                
                [get_id_Group addObject:[[[values valueForKey:@"groups"]valueForKey:@"id"]objectAtIndex:indexPath.row]];
                    
                [_cellSelected addObject:indexPath];
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
                
            }
            else
            {
                
            
            }
            
            
        }
        
        
        
    }
    else
    {
        
        if ([_cellSelected containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }
    
    
    cell.textLabel.text=[[[[values valueForKey:@"groups"]valueForKey:@"name"]objectAtIndex:indexPath.row] stringByConvertingHTMLToPlainText];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    check=true;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        
        
        [_cellSelected removeAllObjects];
        [get_id_Group removeAllObjects];
        [get_id_type  removeAllObjects];
        
        [_cellSelected addObject:indexPath];
        
        
        check_values_tableview=true;
        
    }
    else
    {
        if (check_values_tableview==true) {
            
            [_cellSelected removeAllObjects];
            [get_id_Group removeAllObjects];
            [get_id_type  removeAllObjects];
            
        }
        check_values_tableview=false;
        
        if ([_cellSelected containsObject:indexPath])
        {
            [_cellSelected removeObject:indexPath];
            
            
            
                [get_id_Group removeObjectsInArray:[get_id_Group filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[[[values valueForKey:@"groups"]valueForKey:@"id"]objectAtIndex:indexPath.row]]]];
                
            
            
            
        }
        else
        {
            [_cellSelected addObject:indexPath];
            
//            if ([[[values valueForKey:@"type"]objectAtIndex:indexPath.row]isEqualToString:@"course"]) {
//                
//                [get_id_type addObject:[[values valueForKey:@"id"]objectAtIndex:indexPath.row]];
//                
//            }
//            else
//            {
                [get_id_Group addObject:[[[values valueForKey:@"groups"]valueForKey:@"id"]objectAtIndex:indexPath.row]];
                
          }
            
        
            
            
            }
    
    
    
    
    
    [tableView reloadData];
    
}


@end
