//
//  Selection_list_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 30/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Selection_list_ViewController.h"
#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ImageCustomClass.h"
@interface Selection_list_ViewController ()

@end

@implementation Selection_list_ViewController
@synthesize values;
@synthesize Main_values;
@synthesize Sub_values;


-(void)Navigation_bar
{
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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

    
//    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add filter" value:@"" table:nil];

    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(doneEditing)];
//    [[self navigationItem] setRightBarButtonItem:doneButton];

    
    
    
    
}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self Navigation_bar];
    
    
    check_values_tableview=false;
    
    get_id_Group=[[NSMutableArray alloc]init];
    
    
    self.navigationController.navigationBarHidden=NO;
    
    mtable_view=[[UITableView alloc]init];
    mtable_view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mtable_view.delegate=self;
    mtable_view.dataSource=self;
    [self.view addSubview:mtable_view];
    
    
    for (int s=0;s<[[values valueForKey:Main_values]count] ; s++) {
        
        [get_id_Group addObject:@""];
    }
 
    
    
}

- (void)doneEditing {
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"Publish_Updated_Draft" forKey:@"Publish_type"];
    }
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]);

    
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF!=%@ ",@""];
    NSArray*   myArray = [get_id_Group filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",myArray);
    
    
    
    if ([Main_values isEqualToString:@"groups"]) {
        
        
              [[NSNotificationCenter defaultCenter]
         postNotificationName:_notification
         object:myArray];
        
        [[NSUserDefaults standardUserDefaults]setObject:myArray forKey:@"EDU_Group_List"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
    }
    
  else  if ([Main_values isEqualToString:@"curriculum_tags"])
  {
      
      [[NSNotificationCenter defaultCenter]
       postNotificationName:_notification
       object:myArray];

  }
    
  else  if ([Main_values isEqualToString:@"students"])
  
  {
      
      [[NSUserDefaults standardUserDefaults]setObject:myArray forKey:@"EDU_Student_List"];
      [[NSUserDefaults standardUserDefaults]synchronize];

      
      
      
      [[NSNotificationCenter defaultCenter]
       postNotificationName:_notification
       object:myArray];

  }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    }


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Main_values isEqualToString:@"curriculum_tags"])
    {
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    check=true;
        
    
     if ([Main_values isEqualToString:@"curriculum_tags"])
     {
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
         
         
           [get_id_Group replaceObjectAtIndex:0 withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
         
     }
    
    
    
    else
    {
        if (![Main_values isEqualToString:@"students"])
        {
    
    if (indexPath.row==0) {
        
        
        check_values_tableview=true;
        check_values=true;
        
        [_values_select removeAllObjects];
        
        
        [mtable_view reloadData];
        
        UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
        
        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@"all"];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
     

        
    }
    else
    {
        check_values_tableview=true;

        
        if (check_values==true) {
            
            [mtable_view reloadData];
            check_values=false;
            
            [get_id_Group replaceObjectAtIndex:0 withObject:@""];
            
            
            
        }
    
        
        
    UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
        
        
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
//        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        
        
        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
        
       // [get_id_Group addObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:Sub_values]];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    }
            }
        
        
        else
        {
            UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
            
            
        
            
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
//                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                
               
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[values valueForKey:Main_values]count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    
    if ([Main_values isEqualToString:@"groups"]) {
    
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]==0 && check==false) {
        
        for (int tag=0;tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]; tag++) {
            
            NSLog(@"%@",[[values valueForKey:@"id"]objectAtIndex:indexPath.row]);
            
            NSLog(@"%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]objectAtIndex:tag]);
            
            if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]objectAtIndex:tag]isEqualToString:@"all"] || [[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]objectAtIndex:tag]isEqualToString:@"alla"]) {
                if (indexPath.row==0) {
                    check_values=true;
                }

            }
            
            
            if ([[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"] isEqualToString:[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]objectAtIndex:tag]]) {
                
                
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
                
            }
            else
            {
                
            }
            
            
        }
        
        
       }
    else
    {
        

    
//        cell.accessoryType = UITableViewCellAccessoryNone;

        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
    }
    }
    
    else
    {
        if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]count]==0 && check==false) {
            
            for (int tag=0;tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]count]; tag++) {
                
                NSLog(@"%@",[[values valueForKey:@"id"]objectAtIndex:indexPath.row]);
                
                NSLog(@"%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]objectAtIndex:tag]);
                
              
                
                
                if ([[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"] isEqualToString:[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]objectAtIndex:tag]]) {
                    
                    
                    
                    [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                    
                    
                }
                else
                {
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            
            
//            cell.accessoryType = UITableViewCellAccessoryNone;
            
            [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
        }

    }
    }
    
    
    if ([get_id_Group[indexPath.row] isEqualToString:@""]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    cell.textLabel.text=[[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:Sub_values] stringByConvertingHTMLToPlainText];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
