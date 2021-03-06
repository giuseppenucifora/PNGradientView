//
//  PNGradientView.h
//  Pods
//
//  Created by Giuseppe Nucifora on 12/01/16.
//
//

#import <UIKit/UIKit.h>

@interface PNGradientView : UIView

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint;

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint angle:(CGFloat) angle;

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint endPoint:(CGPoint) endPoint;

@end
