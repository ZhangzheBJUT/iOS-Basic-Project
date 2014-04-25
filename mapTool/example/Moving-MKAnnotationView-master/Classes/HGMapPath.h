
#import <MapKit/MapKit.h>

#define kPathLoadedNotification @"Path Loaded Notification" 
#define MINIMUM_METERS_BETWEEN_PATH_POINTS 5.0


@interface HGMapPath : NSObject
{

  MKMapPoint *points;
  NSUInteger pointCount;
  NSUInteger pointSpace;    
}

- (id) initFromFile : (NSString *) file; 

@property (readonly) MKMapPoint *points;
@property (readonly) NSUInteger pointCount;
           


@end
