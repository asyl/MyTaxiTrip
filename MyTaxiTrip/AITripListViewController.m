//
//  ViewController.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AITripListViewController.h"

// ViewModels
#import "AITripListViewModel.h"
// Cells
#import "AITripCell.h"
// Controllers
#import "AIDetailViewController.h"

@interface AITripListViewController () <UITableViewDataSource, UITableViewDelegate, AITripViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AITripListViewController

static NSString *CellIdentifier = @"tripCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Trips List";
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 60;
}

- (void)viewWillAppear:(BOOL)animated {
  [self.viewModel fetchList];
  [self.tableView reloadData];
  
  NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
  if (indexPath) {
    [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
  }
}


#pragma mark - View Model delegate methods

- (void)contentDidUpdate {
  [self.tableView reloadData];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  AITripCell *cell = (AITripCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}


#pragma mark - Private Methods

- (void)configureCell:(AITripCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  cell.addressLabel.text = [self.viewModel addressAtIndexPath:indexPath];
  cell.dateLabel.text = [self.viewModel dateAtIndexPath:indexPath];
  cell.rateLabel.text = [self.viewModel rateAtIndexPath:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqual: @"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    AIDetailViewController *detailController = segue.destinationViewController;
    detailController.viewModel = [self.viewModel detailViewModelForIndexPath:indexPath];
  }
}


@end
