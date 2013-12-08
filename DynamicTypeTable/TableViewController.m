//
//  TableViewController.m
//  DynamicTypeTable
//
//  Created by koogawa on 2013/12/08.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) NSArray *textArray;
@end

#define CELL_FONT [UIFont preferredFontForTextStyle:UIFontTextStyleBody]

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];

    self.textArray = @[@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                       @"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                       @"I am Hoge",
                       @"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                       @"Nam liber te conscient to factor tum poen legum odioque civiuda."];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private

- (void)preferredContentSizeChanged:(NSNotification *)aNotification
{
    // テーブルビューを再読み
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.font = CELL_FONT;
    cell.textLabel.text = [self.textArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルに表示される文字列
    NSString *labelText = [self.textArray objectAtIndex:indexPath.row];

    // セルに表示される文字列のフォント
    UIFont *labelFont = CELL_FONT;

    // 余白
    CGFloat PADDING_OUTER = 30.0;

    CGRect totalRect =
    [labelText boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)
                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                         attributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]
                            context:nil];
    return totalRect.size.height + PADDING_OUTER;
}

@end
