//
//  AIDetailViewController.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AIDetailViewController.h"

// View Models
#import "AIDetailViewModel.h"

enum {
  AIDetailViewControllerInfoSection = 0,
  AIDetailViewControllerAddressSection,
  AIDetailViewControllerRateSection,
  numberOfSections
};

enum {
  AIDetailViewControllerInfoDate = 0,
  AIDetailViewControllerInfoPlanName,
  AIDetailViewControllerInfoCost,
  infoSectionItemsCount
};

enum {
  AIDetailViewControllerAddressFrom = 0,
  AIDetailViewControllerAddressTo,
  AIDetailViewControllerAddressDistance,
  addressSectionItemsCount
};


@interface AIDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AIDetailViewController

static NSString *infoRightIdentifier = @"infoCell";
static NSString *infoLeftIdentifier = @"infoLeftCell";
static NSString *rateIdentifier = @"rateCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Trip Detail";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == AIDetailViewControllerInfoSection) {
    return infoSectionItemsCount;
  } else if (section == AIDetailViewControllerAddressSection) {
    return addressSectionItemsCount;
  } else if (section == AIDetailViewControllerRateSection) {
    return 1;
  }
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == AIDetailViewControllerInfoSection) {
    return @"Info";
  } else if (section == AIDetailViewControllerAddressSection) {
    return @"Route Info";
  } else {
    return @"Rate the Trip";
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == AIDetailViewControllerInfoSection) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoRightIdentifier];
    if (indexPath.row == AIDetailViewControllerInfoDate) {
      cell.textLabel.text = @"Date";
      cell.detailTextLabel.text = self.viewModel.tripDate;
    } else if (indexPath.row == AIDetailViewControllerInfoPlanName){
      cell.textLabel.text = @"Plan Name";
      cell.detailTextLabel.text = self.viewModel.tripPlanName;
    } else {
      cell.textLabel.text = @"Total Cost";
      cell.detailTextLabel.text = self.viewModel.tripCost;
    }
    return cell;
  } else if (indexPath.section == AIDetailViewControllerAddressSection) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoLeftIdentifier];
    if (indexPath.row == AIDetailViewControllerAddressFrom) {
      cell.textLabel.text = @"From";
      cell.detailTextLabel.text = self.viewModel.tripAddress;
    } else if (indexPath.row == AIDetailViewControllerAddressTo) {
      cell.textLabel.text = @"To";
      cell.detailTextLabel.text = self.viewModel.tripAddressTo;
    } else {
      cell = [tableView dequeueReusableCellWithIdentifier:infoRightIdentifier];
      cell.textLabel.text = @"Total Distance";
      cell.detailTextLabel.text = self.viewModel.tripDist;
    }
    return cell;
  } else {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rateIdentifier];
    cell.textLabel.text = @"Rate";
    cell.detailTextLabel.text = self.viewModel.tripRate;
    return cell;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.section == AIDetailViewControllerRateSection) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rate Trip" message:@"Please choose your rate for this trip" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *actionTitles = @[@"One", @"Two", @"Three", @"Four", @"Five"];
    
    void (^actionHandler)(UIAlertAction *) = ^(UIAlertAction * _Nonnull action) {
      int32_t rate = (int32_t) [actionTitles indexOfObject:action.title] + 1;
      [self.viewModel rateWith:rate];
      [self.tableView reloadData];
    };
    
    for (int i = 0; i < actionTitles.count; i++) {
      UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                          style:UIAlertActionStyleDefault
                                                        handler:actionHandler];
      [alertController addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
  }
}


@end
