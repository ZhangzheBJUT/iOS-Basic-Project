
#import <MapKit/MapKit.h>

@interface HGMovingAnnotationView : MKAnnotationView
{
    MKMapView* mapView;
	MKMapPoint lastReportedLocation;
    
	BOOL animating;
	BOOL observingMovement;
}
@property (nonatomic, retain) MKMapView* mapView; 



@end
