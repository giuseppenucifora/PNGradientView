//
//  PNGradientView.m
//  Pods
//
//  Created by Giuseppe Nucifora on 12/01/16.
//
//

#import "PNGradientView.h"
#import <RZDataBinding/RZDataBinding.h>

@interface PNGradientView()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *cgColors;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) BOOL didUpdateConstraints;


@end

@implementation PNGradientView

- (instancetype) init {
    self = [super init];
    if (self) {
        
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint {
    [self setBackgroundLayerWithColors:colors startPoint:startPoint endPoint:CGPointZero];
}

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint angle:(CGFloat) angle {
    
    float c = pow(sinf((2*M_PI*((angle+0.25)/2))),2);
    float d = pow(sinf((2*M_PI*((angle+0.5)/2))),2);
    
    [self setBackgroundLayerWithColors:colors startPoint:startPoint endPoint:CGPointMake(c, d)];
}

- (void) setBackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint endPoint:(CGPoint) endPoint {
 
    if (colors && [colors count] > 0) {
        _colors = [[NSMutableArray alloc] initWithArray:colors];
        [_cgColors removeAllObjects];
        
        for (UIColor *color in colors) {
            [_cgColors addObject:(id)color.CGColor];
        }
        
        _startPoint = startPoint;
        _endPoint = endPoint;
        
        //[_gradientLayer removeFromSuperlayer];
        if (!_gradientLayer) {
            _gradientLayer = [CAGradientLayer layer];
        }
        
        _gradientLayer.colors = _cgColors;
        if (self.translatesAutoresizingMaskIntoConstraints) {
            
            [_gradientLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }
        else {
            
            [_gradientLayer setFrame:self.bounds];
        }
        
        
        _gradientLayer.startPoint = _startPoint;
        if (!CGPointEqualToPoint(_endPoint, CGPointZero)) {
            _gradientLayer.endPoint = _endPoint;
        }
        
        if (!CGRectEqualToRect(_gradientLayer.frame, CGRectZero)) {
            [self.layer insertSublayer:_gradientLayer atIndex:0];
        }
        
    }
    else {
        [_gradientLayer removeFromSuperlayer];
    }
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_gradientLayer) {
            [self setBackgroundLayerWithColors:_colors startPoint:_startPoint];
        }
    });
}

- (void) setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_gradientLayer) {
            [self setBackgroundLayerWithColors:_colors startPoint:_startPoint];
        }
    });
}

/*
 NSString* const kRZDBChangeKeyObject  = @"RZDBChangeObject";
 NSString* const kRZDBChangeKeyOld     = @"RZDBChangeOld";
 NSString* const kRZDBChangeKeyNew     = @"RZDBChangeNew";
 NSString* const kRZDBChangeKeyKeyPath = @"RZDBChangeKeyPath";
 */

- (void) valueChanged:(NSDictionary *) value {
    if ([value objectForKey:kRZDBChangeKeyNew]) {
        if(_gradientLayer) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setBackgroundLayerWithColors:_colors startPoint:_startPoint];
            });
        }
    }
}

@end
