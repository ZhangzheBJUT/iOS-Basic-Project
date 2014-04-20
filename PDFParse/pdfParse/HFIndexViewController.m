//
//  HFIndexViewController.m
//  HaiFeng
//
//  Created by zhangzhe on 13-12-27.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//

#import "HFIndexViewController.h"
#import "HFViewController.h"

@interface HFIndexViewController ()
@property (nonatomic,strong) NSArray *sectionName;
@property (nonatomic,strong) NSMutableArray *indexList;
@end

@implementation HFIndexViewController
@synthesize viewController = _viewController;
@synthesize indexList      = _indexList;


-(NSMutableArray*) indexList
{
    if (nil == _indexList)
    {
        _indexList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return _indexList;
}
-(NSArray*) sectionName
{
    if (nil == _sectionName)
    {
        _sectionName = [[NSMutableArray alloc] init];
    }
    
    return _sectionName;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.title = @"海丰通航";
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"index"
                                                       ofType:@"plist"]];
    [self.indexList addObjectsFromArray:array];
     self.sectionName = @[@"海上直升机保障系统",@"通航机场解决方案",
                         @"临时起降点解决方案",@"航空应急保障系统",
                         @"低空监视与服务"];
    
    
    UIBarButtonItem *index = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    NSArray *itemArray = @[index];
    [self.navigationItem setRightBarButtonItems:itemArray animated:YES];

}
-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if (self.sectionName != nil)
    {
        count = [self.sectionName count];
    }
    
    return count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if (self.sectionName != nil)
    {
        title = [self.sectionName objectAtIndex:section];
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (self.indexList != nil)
    {
        NSDictionary *dict = [self.indexList objectAtIndex:section];
        if (dict != nil)
        {
            count = [dict count];
        }
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger sectionNum = indexPath.section;
    NSArray *arr = [self.indexList objectAtIndex:sectionNum];
    
    NSInteger rowNumber = indexPath.row;
    NSString *content = [arr objectAtIndex:rowNumber];
    
    NSArray *result =[content componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"-"]];
    
    if (result.count>=1) {
        content = [result objectAtIndex:0];
        NSString *tempcontent = [NSString stringWithFormat:@"%@",content];
        cell.textLabel.text  = tempcontent;
    }
    else
    {
        cell.textLabel.text = nil;
    }
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionNum = indexPath.section;
    NSArray *arr = [self.indexList objectAtIndex:sectionNum];
    
    NSInteger rowNumber = indexPath.row;
    NSString *content = [arr objectAtIndex:rowNumber];
    
    NSArray *result =[content componentsSeparatedByCharactersInSet:
                      [NSCharacterSet characterSetWithCharactersInString:@"-"]];

    rowNumber = [[result objectAtIndex:1] integerValue];
    
    if (self.viewController != nil) {
         [self.viewController goToPage:rowNumber];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
