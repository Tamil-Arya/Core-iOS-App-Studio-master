//
//  Edit_select_student_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 22/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Edit_select_student_ViewController.h"
#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
@interface Edit_select_student_ViewController ()

@end

@implementation Edit_select_student_ViewController
@synthesize values;
@synthesize Main_values;
@synthesize Sub_values;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"%@",values);
    
    
     NSLog(@"%@",[[values valueForKey:@"name"]objectAtIndex:0]);
    
    
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
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]count]==0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF!=%@ ",@""];
      myArray = [get_id_Group filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",myArray);
        

    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF!=%@ ",@""];
          myArray = [get_id_Group filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",myArray);
        

    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:myArray forKey:@"STU_Data"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
        [[NSNotificationCenter defaultCenter]
         postNotificationName:_notification
         object:myArray];
    
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
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
        
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            [get_id_Group replaceObjectAtIndex:indexPath.row withObject:@""];
//            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            
            
            [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
            
            // [get_id_Group addObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:Sub_values]];
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    NSLog(@"%@",get_id_Group);
    [tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[values valueForKey:Main_values] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"Data %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]);
    NSLog(@"STU_Data %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Data"]count]==0) {
        
        
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]count]!=0) {
            
            
            
            
            for (int tag=0; tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]count]; tag++) {
                
                if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]objectAtIndex:tag]isEqualToString:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]]) {
                    
                    [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                 // cell.accessoryType = UITableViewCellAccessoryNone;
                }
                
            }

            
            
        }
        
        else
        {
        
        [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values] valueForKey:@"id"]objectAtIndex:indexPath.row]];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }
    
    else
    {
        
        
        
        for (int tag=0; tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]count]; tag++) {
            
            if ([[[[NSUserDefaults standardUserDefaults]valueForKey:@"STU_Data"]objectAtIndex:tag]isEqualToString:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]]) {
            
                
                [get_id_Group replaceObjectAtIndex:indexPath.row withObject:[[[values valueForKey:Main_values]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
               //cell.accessoryType = UITableViewCellAccessoryNone;
            
            }
            

                   }
       
            }
    
    if ([[get_id_Group objectAtIndex:indexPath.row] isEqualToString:@""]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    cell.textLabel.text=[[[[values valueForKey:Main_values] valueForKey:@"name"]objectAtIndex:indexPath.row] stringByConvertingHTMLToPlainText];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
