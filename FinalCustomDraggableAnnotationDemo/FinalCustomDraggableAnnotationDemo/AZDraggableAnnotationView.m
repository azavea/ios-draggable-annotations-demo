//
// Copyright (c) 2012 Azavea
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "AZDraggableAnnotationView.h"

@implementation AZDraggableAnnotationView

@synthesize mapView, delegate;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
	if (self) {
		self.image = [UIImage imageNamed:@"draggable_annotation_icon"];
        [self clearTouch];
	}
	return self;
}

/**
 Set the touchXOffset and touchYOffset members by calculating the distance from the
 the touch to the center of the annotation view.
 */
- (void)setOffsetsFromTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    touchXOffset = point.x - self.bounds.size.width / 2.0;
    touchYOffset = point.y - self.bounds.size.height / 2.0;
}

/**
 Set the coordinate of the MKPointAnnotation by adding the touchXOffset and
 touchYOffset to the touch and then using the MKMapView to translate the pixel
 location to a map coordinate.
 */
- (void)updateCoordinateFromTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:nil]; // nil means "use the application window"
    point.x -= touchXOffset;
    point.y -= touchYOffset;
    CLLocationCoordinate2D newCoordinate = [mapView convertPoint:point
                                            toCoordinateFromView:nil]; // nil means "use the application window"
    self.annotation.coordinate = newCoordinate;
}

/**
 Reset the touch tracking member variables to an initial state.
 */
- (void)clearTouch
{
    isMoving = NO;
    touchXOffset = 0.0;
    touchYOffset = 0.0;
}

#pragma mark UIResponder delgate methods

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    isMoving = YES;
    [self setOffsetsFromTouch:[[event allTouches] anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (isMoving) {
        [self updateCoordinateFromTouch:[[event allTouches] anyObject]];
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTouch];
    [self.delegate movedAnnotation:self.annotation];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTouch];
}

@end
