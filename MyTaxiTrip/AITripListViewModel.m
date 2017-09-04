//
//  AITripListViewModel.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AITripListViewModel.h"

// Model
#import "AITrip.h"

// ViewModels
#import "AIDetailViewModel.h"

@interface AITripListViewModel () <NSFetchedResultsControllerDelegate>

@end

@implementation AITripListViewModel

- (instancetype)initWithModel:(id)model {
  self = [super init];
  if (self) {
    _model = model;
  }
  return self;
}


#pragma mark - Public Methods

- (void)fetchList {
  [self.fetchedResultsController performFetch:nil];
}

- (NSInteger)numberOfSections {
  return self.fetchedResultsController.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
  return sectionInfo.numberOfObjects;
}

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath {
  AITrip *trip = [self tripAtIndexPath:indexPath];
  NSDate *date = trip.date;
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"h:mm a, MMM d yyy"];
  return [formatter stringFromDate:date];
}

- (NSString *)addressAtIndexPath:(NSIndexPath *)indexPath {
  AITrip *trip = [self tripAtIndexPath:indexPath];
  return trip.address;
}

- (NSString *)rateAtIndexPath:(NSIndexPath *)indexPath {
  AITrip *trip = [self tripAtIndexPath:indexPath];
  if (trip.rate > 0) {
    if (trip.rate > 1) {
      return [NSString stringWithFormat:@"%d stars", trip.rate];
    } else {
      return [NSString stringWithFormat:@"%d star", trip.rate];
    }
  } else {
    return @"Not Rated";
  }
}

- (AIDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *)indexPath {
  AIDetailViewModel *detailViewModel = [[AIDetailViewModel alloc]
                                        initWithModel:[self tripAtIndexPath:indexPath]];
  return detailViewModel;
}


#pragma mark - Private Methods

- (AITrip *)tripAtIndexPath:(NSIndexPath *)indexPath {
  return [self.fetchedResultsController objectAtIndexPath:indexPath];
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  // Entity name that we should fetch
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"AITrip" inManagedObjectContext:self.model];
  [fetchRequest setEntity:entity];
  
  // Set the batch size to a suitable number.
  [fetchRequest setFetchBatchSize:20];
  
  // SortDescriptor to sort out the list by specified key
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
  NSArray *sortDescriptors = @[dateSort];
  
  [fetchRequest setSortDescriptors:sortDescriptors];
  
  
  NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.model sectionNameKeyPath:nil cacheName:@"TripList"];
  controller.delegate = self;
  self.fetchedResultsController = controller;
  
  NSError *error = nil;
  if (![self.fetchedResultsController performFetch:&error]) {
    // Replace this implementation with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _fetchedResultsController;
}


#pragma mark - fetchedResultsController delegate methods

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.delegate contentDidUpdate];
}



@end
