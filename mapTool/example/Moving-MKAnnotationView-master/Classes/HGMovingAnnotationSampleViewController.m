
#import "HGMovingAnnotationSampleViewController.h"
#import "HGMovingAnnotation.h"
#import "HGMovingAnnotationView.h"

@implementation HGMovingAnnotationSampleViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

	// create the path for the moving object
	NSString *nmeaLogPath = [[NSBundle mainBundle] pathForResource:@"path" ofType:@"nmea"];
	HGMapPath *path = [[HGMapPath alloc] initFromFile:nmeaLogPath];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadPath:) name:kPathLoadedNotification object:path];
	
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

	return YES;
}


- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}


- (void) didLoadPath : (NSNotification*) notification
{
	// initialize our moving object 
	HGMapPath *path = (HGMapPath*)[notification object];
	HGMovingAnnotation *movingObject = [[[HGMovingAnnotation alloc] initWithMapPath:path] autorelease]; //the annotation retains its path
	[path release];
	
	// add the annotation to the map
	[_mapView addAnnotation:movingObject];
	
	// zoom the map around the moving object
	MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
	MKCoordinateRegion region = MKCoordinateRegionMake(MKCoordinateForMapPoint(movingObject.currentLocation), span); 
	[_mapView setRegion:region animated:YES];
	
	// start moving the object 
	[movingObject start];
}


#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
{
	static NSString *kMovingAnnotationViewId = @"HGMovingAnnotationView";
	
	HGMovingAnnotationView *annotationView = (HGMovingAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kMovingAnnotationViewId];
    
	if (!annotationView)
    {
		annotationView = [[HGMovingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kMovingAnnotationViewId];
	}
	
	//configure the annotation view 
	annotationView.image = [UIImage imageNamed:@"symbol-moving-annotation.png"];
	annotationView.bounds = CGRectMake(0, 0, 20, 20); //initial bounds (default)
	annotationView.mapView = mapView;
	
	return annotationView;
	
}

@end
