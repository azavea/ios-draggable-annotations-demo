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

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol AZDraggableAnnotationViewDelegate <NSObject>
@required
- (void)movedAnnotation:(MKPointAnnotation *)annotation;
@end

@interface AZDraggableAnnotationView : MKAnnotationView {
    /**
     A flag to indicate whether this annotation is in the middle of being dragged
     */
    BOOL isMoving;
    
    /**
     The horizontal distance in pixels from the center of the annotation to the point
     at which the user touched and held the annotation. This annotation has a large
     'handle' so that it can be dragged without the center being obscured by the user's
     finger.
     */
    float touchXOffset;
    
    /**
     The vertical distance in pixels from the center of the annotation to the point
     at which the user touched and held the annotation. This annotation has a large
     'handle' so that it can be dragged without the center being obscured by the user's
     finger.
     */
    float touchYOffset;
}

/**
 A delegate that to receive events
 */
@property (nonatomic, strong) id <AZDraggableAnnotationViewDelegate> delegate;

/**
 A reference to the MKMapView to which this annotation has been added
 */
@property (nonatomic, strong) MKMapView *mapView;

@end
