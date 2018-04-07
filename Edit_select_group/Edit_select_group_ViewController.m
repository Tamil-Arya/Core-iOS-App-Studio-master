//
//  Edit_select_group_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 22/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Edit_select_group_ViewController.h"
#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
@interface Edit_select_group_ViewController ()

@end

@implementation Edit_select_group_ViewController

@synthesize values;
@synthesize Main_values;
@synthesize Sub_values;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"%@",[_values_select valueForKey:Main_values]);
    
    
    check_values_tableview=false;
    
    get_id_Group=[[NSMutableArray alloc]init];
    
    
    self.navigationController.navigationBarHidden=NO;
    
    mtable_view=[[UITableView alloc]init];
    mtable_view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mtable_view.delegate=self;
    mtable_view.dataSource=self;
    [self.view addSubview:mtable_view];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneEditing)];

    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(doneEditing)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    
    for (int s=0;s<[[values valueForKey:Main_values]count] ; s++) {
        
        [get_id_Group addObject:@""];
    }
    
    
    
}

- (void)doneEditing {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF!=%@ ",@""];
    NSArray*   myArray = [get_id_Group filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",myArray);
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:_notification
     object:myArray];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:myArray forKey:@"Data"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Main_values isEqualToString:@"curriculum_tags"])
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    first_check=true;
    
    
    if ([Main_values isEqualToString:@"curriculum_tags"])
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
        
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
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
                
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
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    
                    
                    [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    
                    // [get_id_Group addObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:Sub_values]];
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
        
        
        else
        {
            UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
            
            
            
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[values valueForKey:Main_values]count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    
    if (first_check==false) {
        
        if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]count]==0) {
            
            NSLog(@"%u",[[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]count]);
            
            
            for (int tag=0; tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]count]; tag++) {
                
                if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]objectAtIndex:tag]isEqualToString:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]]) {
                    
                    
                    if ([[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]isEqualToString:@"all"]) {
                        check_values=true;
                    }
                    
                    [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                    //[get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
                }
                
            }
            
        }
        else
        {
            
for (int tag=0; tag<[[[_values_select valueForKey:@"post"] valueForKey:Main_values]count]; tag++)

{
                
                if ([[[[[_values_select valueForKey:@"post"] valueForKey:Main_values]objectAtIndex:tag]valueForKey:@"id"]isEqualToString:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]])
                    
                {
                    
if ([[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]isEqualToString:@"all"])

{
    
                        check_values=true;
                    }
                    
                    [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                    //[get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
                }
            }
        }
    }
    else
    {
        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
    }
    
    cell.textLabel.text=[[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:Sub_values] stringByConvertingHTMLToPlainText];
    
    return cell;
}

@end
