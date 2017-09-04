//
//  AITripListViewModel.h
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AIDetailViewModel;

// Delegate for View Model to callback about updates
@protocol AITripViewModelDelegate <NSObject>
- (void)contentDidUpdate;
@end


@interface AITripListViewModel : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readonly) NSManagedObjectContext *model;
@property (nonatomic, weak) id<AITripViewModelDelegate> delegate;

- (instancetype)initWithModel:(id)model;

- (void)fetchList;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (AIDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *)indexPath;

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)addressAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)rateAtIndexPath:(NSIndexPath *)indexPath;

@end
