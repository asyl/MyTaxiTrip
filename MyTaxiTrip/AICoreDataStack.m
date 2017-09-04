//
//  AICoreDataStack.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AICoreDataStack.h"

//Models
#import "AITrip.h"

@interface AICoreDataStack ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AICoreDataStack

+ (instancetype)defaultStack {
  static AICoreDataStack *stack;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    stack = [[self alloc] init];
  });
  return stack;
}

- (void)saveContext {
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

#pragma mark - Core Data Stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext) {
    return _managedObjectContext;
  }

  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator) {
    _managedObjectContext = [[NSManagedObjectContext alloc]
                             initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel) {
    return _managedObjectModel;
  }

  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyTaxiTrip" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator) {
    return _persistentStoreCoordinator;
  }

  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyTaxiTrip.sqlite"];

  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
  }

  return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Public Methods

- (void)ensureInitialLoad {
  NSString *initialLoadKey = @"Initial Load";
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

  BOOL hasInitialLoad = [userDefaults boolForKey:initialLoadKey];
  if (!hasInitialLoad) {
    [userDefaults setBool:YES forKey:initialLoadKey];

    //@*****************************************************************************&
    //*------------------------< Create Some Mock Examples >------------------------*
    //&*****************************************************************************@
    
    //' ' '''''''''=#= ' ''''-==*#######***===++* -'==+==**###**--+==============-'
    //'''-''''''''''-*#'''''''--+*#######*******==*-''-*=*########+--===============+
    //'''''''''' ''''#* ' '''''-'*####*====+=+======---**==********=-+===============
    //'-'''''''-''''=#=  '' '''-*#*= -=-'---'-''''-=--+ -' ''''''  -++===============
    //++=+++=++++--'=#= ''''''+*=  '-' '''  ' '''-*='+=-''  '    '    '========**=*==
    //============+-*# -+='''=+   -  '''-=''' ''''##=-*  ''''      '    =*===*******=
    //=============+##=-'-'-+    '   ''=##=''' ''-*#=-='  '=*+    '      =*===****=*=
    //==============#==#**--     ' ''-+=*=-''''''+*='-+=--'-=#'       ' ' =*==*******
    //==============-*###-+       '-=**##**======*=-'-++==++==*=          '=***=*****
    //==============*###++       '--++==+==+===****-=-----==*=+    '       '*********
    //==============###==         '-+==     ''=###*=''==-=+*##==+'-+      ' =********
    //=============*##*+'    '    ''--+-   '''=****+   -'  +=*=+-'''         =*******
    //============*###--      '    ''--+'  '+=****'         '-++-'-   '  ''   *******
    //*===========###=+ '         '  '-++  =***#=             -  -'     '  '  =******
    //*===*======####-               ''-++*****-               '---       '''' =*****
    //**=****===*###='     '   -+++--''--+-***'-               ' ++-      ''''  *****
    //***=***==*###*' ' '     ''''-++++++--===   ''''-''''-''''''+**+     '-'--'=****
    //**=*****=##*=         '' '+=====+--'''  '     '  '  '''-''         '-+==-'=****
    //**=*******='''   ' '  ' ''-+++-''''''    ''        '-+--         '  ''-+-=*****
    //**=*****=*=+-''''''   '----+++--''''''    ''    ---' '-='         ''-===*******
    //******=-=*==+''-'' '''-++++====+--'''  '  '    -  '+-+*#=   ' -'+====**********
    //**=***=====-''''--'''-+==========+---''''''''   ' '-+=*##= ' ''-+=====***======
    //#* -U *****==-''-'''''-===*****======+++++----''''+=***===  ''' ' '++==*==++-++
    //#*******==++---'-'''''' '-==*###**===========+----=*##*='  ' ' '  ''''+========
    {
      AITrip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip.tripId = 1;
      trip.date = [[NSDate alloc] initWithTimeIntervalSince1970:1504350000];
      trip.address = @"3 Shakhrisabz Street, Tashkent, Uzbekistan";
      trip.rate = 4;
      trip.addressTo = @"25 Mirabad Street, Tashkent 100031, Uzbekistan";
      trip.totalCost = 6000;
      trip.totalDist = 3615;
      trip.planName = @"Econom";

      AITrip *trip1 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip1.tripId = 2;
      trip1.date = [[NSDate alloc] initWithTimeIntervalSince1970:1504041000];
      trip1.address = @"25 Mirabad Street, Tashkent 100031, Uzbekistan";
      trip1.rate = 0;
      trip1.addressTo = @"8 Vosit Vokhidov St, Tashkent, Uzbekistan";
      trip1.totalCost = 7000;
      trip1.totalDist = 4112;
      trip1.planName = @"Comfort";

      AITrip *trip2 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip2.tripId = 3;
      trip2.date = [[NSDate alloc] initWithTimeIntervalSince1970:1503932000];
      trip2.address = @"8 Vosit Vokhidov St, Tashkent, Uzbekistan";
      trip2.rate = 0;
      trip2.addressTo = @"45 Mariam Yakubova Street, Tashkent, Uzbekistan";
      trip2.totalCost = 8000;
      trip2.totalDist = 3615;
      trip2.planName = @"Express";

      AITrip *trip3 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip3.tripId = 4;
      trip3.date = [[NSDate alloc] initWithTimeIntervalSince1970:1503823000];
      trip3.address = @"45 Mariam Yakubova Street, Tashkent, Uzbekistan";
      trip3.rate = 3;
      trip3.addressTo = @"18 Shota Rustaveli Street, Tashkent, Uzbekistan";
      trip3.totalCost = 6000;
      trip3.totalDist = 3615;
      trip3.planName = @"Superman";

      AITrip *trip4 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip4.tripId = 5;
      trip4.date = [[NSDate alloc] initWithTimeIntervalSince1970:1503714000];
      trip4.address = @"18 Shota Rustaveli Street, Tashkent, Uzbekistan";
      trip4.rate = 2;
      trip4.addressTo = @"33 Chekhov Street, Tashkent, Uzbekistan";
      trip4.totalCost = 8000;
      trip4.totalDist = 3615;
      trip4.planName = @"Express";

      AITrip *trip5 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip5.tripId = 6;
      trip5.date = [[NSDate alloc] initWithTimeIntervalSince1970:1503605000];
      trip5.address = @"33 Chekhov Street, Tashkent, Uzbekistan";
      trip5.rate = 5;
      trip5.addressTo = @"20 Aybek Street, Tashkent, Uzbekistan";
      trip5.totalCost = 9000;
      trip5.totalDist = 3615;
      trip5.planName = @"Comfort";

      AITrip *trip6 = [NSEntityDescription insertNewObjectForEntityForName:@"AITrip"
                                                   inManagedObjectContext:self.managedObjectContext];
      trip6.tripId = 7;
      trip6.date = [[NSDate alloc] initWithTimeIntervalSince1970:1503596000];
      trip6.address = @"20 Aybek Street, Tashkent, Uzbekistan";
      trip6.rate = 0;
      trip6.addressTo = @"3 Shakhrisabz Street, Tashkent, Uzbekistan";
      trip6.totalCost = 10000;
      trip6.totalDist = 3615;
      trip6.planName = @"Superman";
    }


    [[AICoreDataStack defaultStack] saveContext];
  }
}

@end
