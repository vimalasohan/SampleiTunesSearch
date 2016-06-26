//
//  ActivityView.m
//  CustomWaitHUD
//
//  Created by $heb!n Koshy on 2/18/16.
//  Copyright © 2016 $heb!n Koshy. All rights reserved.
//

#import "SHActivityView.h"

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees) ((pi * degrees) / 180)
#define dotEnteringDelay 0.6


@interface SHActivityView ()
{
    UIView *viewActivitySquare;
    UIView *viewNotRotate;
    BOOL isAnimating;
}

@end

@implementation SHActivityView


-(void)showAndStartAnimate
{
    if (isAnimating)
    {
        NSLog(@"WARNING already animation started");
        return;
    }
    else
    {
        isAnimating = YES;
    }
    
    [self setAlpha:0.0];
    if (!self.backgroundColor && _spinnerSize != kSHSpinnerSizeTiny && _spinnerSize != kSHSpinnerSizeSmall&& _spinnerSize != kSHSpinnerSizeMedium)
    {
        [self setBackgroundColor:[UIColor colorWithWhite:0.2f alpha:0.5f]];
    }
    else
    {
        if ([self.backgroundColor isEqual:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]] || [self.backgroundColor isEqual:[UIColor whiteColor]])
        {
            NSLog(@"WARNING background color is white, so you cannot see the spinner");
        }
    }
    
    if (_disableEntireUserInteraction)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    viewNotRotate = self;
    viewActivitySquare = [[UIView alloc]init];
    CGRect frameViewActivitySquare = CGRectMake(0, 0, 0, 0);
    if (_spinnerSize == kSHSpinnerSizeTiny)
    {
        frameViewActivitySquare = CGRectMake(0, 0, 30, 30);
        [self setFrame:frameViewActivitySquare];
    }
    if (_spinnerSize == kSHSpinnerSizeSmall)
    {
        frameViewActivitySquare = CGRectMake(0, 0, 50, 50);
        [self setFrame:frameViewActivitySquare];
    }
    else if (_spinnerSize == kSHSpinnerSizeMedium || _spinnerSize == kSHSpinnerSizeLarge|| _spinnerSize == kSHSpinnerSizeVeryLarge)
    {
        UILabel *labelCenter;
        UILabel *labelBottom;
        if (_spinnerSize == kSHSpinnerSizeMedium)
        {
            frameViewActivitySquare = CGRectMake(0, 0, 82, 82);
            [viewNotRotate setFrame:CGRectMake(0, 0, 150, 150)];
        }
        else if (_spinnerSize == kSHSpinnerSizeLarge)
        {
            frameViewActivitySquare = CGRectMake(0, 0, 120, 120);
            [viewNotRotate setFrame:CGRectMake(0, 0, 185, 185)];
        }
        else if (_spinnerSize == kSHSpinnerSizeVeryLarge)
        {
            frameViewActivitySquare = CGRectMake(0, 0, 150, 150);
            [viewNotRotate setFrame:CGRectMake(0, 0, 220, 220)];
        }
        if (_centerTitle)
        {
            labelCenter = [[UILabel alloc]initWithFrame:CGRectMake(viewNotRotate.frame.size.width/4, (viewNotRotate.frame.size.height/2) - 15, viewNotRotate.frame.size.width-(2*(viewNotRotate.frame.size.width/4)), 30)];
            if (_centerTitleFont)
            {
                labelCenter.font = _centerTitleFont;
            }
            labelCenter.text = _centerTitle;
            if (_centerTitleColor)
            {
                labelCenter.textColor = _centerTitleColor;
            }
            else
            {
                labelCenter.textColor = [UIColor whiteColor];
            }
            labelCenter.textAlignment = NSTextAlignmentCenter;
            [labelCenter setBackgroundColor:[UIColor clearColor]];
            [labelCenter setAdjustsFontSizeToFitWidth:YES];
            [viewNotRotate addSubview:labelCenter];
        }
        
        if (_bottomTitle)
        {
            CGFloat widthLabelDot = 0.0;
            if(!_stopBottomTitleDotAnimation)
            {
                widthLabelDot = 20;
            }
            labelBottom = [[UILabel alloc]init];
            if (_bottomTitleFont)
            {
                [labelBottom setFont:_bottomTitleFont];
            }
            [labelBottom setBackgroundColor:[UIColor clearColor]];
            labelBottom.text = _bottomTitle;
            [labelBottom setAdjustsFontSizeToFitWidth:YES];
            //CGSize sizeWithFont = [_bottomTitle sizeWithFont:labelBottom.font];
            CGSize sizeWithFont = [_bottomTitle sizeWithAttributes:
                           @{NSFontAttributeName: labelBottom.font}];
            if (sizeWithFont.width < viewNotRotate.frame.size.width)
            {
               CGFloat width = viewNotRotate.frame.size.width - sizeWithFont.width;
                [labelBottom setFrame:CGRectMake((width/2) - (widthLabelDot/2), viewNotRotate.frame.size.height - 35, sizeWithFont.width, 30)];
                
            }
            else
            {
                if (!_stopBottomTitleDotAnimation)
                {                    
                    NSLog(@"WARNING bottom title is too lengthy so Dot animation not possible");
                    _stopBottomTitleDotAnimation = YES;
                }
                [labelBottom setFrame:CGRectMake(0, viewNotRotate.frame.size.height - 35, viewNotRotate.frame.size.width, 30)];
                [labelBottom setTextAlignment:NSTextAlignmentCenter];
            }
            if (_bottomTitleColor)
            {
                labelBottom.textColor = _bottomTitleColor;
            }
            else
            {
                labelBottom.textColor = [UIColor whiteColor];
            }
            [viewNotRotate addSubview:labelBottom];
            
            
            if (!_stopBottomTitleDotAnimation)
            {
                UILabel *labelDot = [[UILabel alloc]initWithFrame:CGRectMake(labelBottom.frame.origin.x + labelBottom.frame.size.width+1, labelBottom.frame.origin.y, widthLabelDot, labelBottom.frame.size.height)];
                if (_bottomTitleFont)
                {
                    [labelDot setFont:_bottomTitleFont];
                }
                [labelDot setBackgroundColor:[UIColor clearColor]];
                [labelDot setAdjustsFontSizeToFitWidth:YES];
                if (_bottomTitleColor)
                {
                    labelDot.textColor = _bottomTitleColor;
                }
                else
                {
                    labelDot.textColor = [UIColor whiteColor];
                }
                [viewNotRotate addSubview:labelDot];
                [self performSelector:@selector(firstDot:) withObject:labelDot afterDelay:dotEnteringDelay];
            }
        }
    }
    [viewActivitySquare setFrame:frameViewActivitySquare];
    [self addSubview:viewActivitySquare];

    
    UIBezierPath *lowerPath = [UIBezierPath bezierPathWithArcCenter:viewActivitySquare.center radius:viewActivitySquare.frame.size.width/2.2 startAngle:DEGREES_TO_RADIANS(-5) endAngle:DEGREES_TO_RADIANS(200) clockwise:YES];
    CAShapeLayer *lowerShape = [self createShapeLayerWith:lowerPath];
    CAGradientLayer *gradientLayerUpper = [CAGradientLayer layer];
    gradientLayerUpper.frame = CGRectMake(0, 0, viewActivitySquare.frame.size.width, viewActivitySquare.frame.size.height);
    UIColor *colorSpinner = _spinnerColor;
    if (!colorSpinner)
    {
        colorSpinner = [UIColor whiteColor];
    }
    gradientLayerUpper.colors = [NSArray arrayWithObjects:(__bridge id)colorSpinner.CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,(__bridge id)[UIColor clearColor].CGColor,nil];
    gradientLayerUpper.startPoint = CGPointMake(0.5, 0.8);
    gradientLayerUpper.endPoint = CGPointMake(2.0, 0.5);
    gradientLayerUpper.mask = lowerShape;
    [viewActivitySquare.layer addSublayer:gradientLayerUpper];
    
    
    
    UIBezierPath *upperPath = [UIBezierPath bezierPathWithArcCenter:viewActivitySquare.center radius:viewActivitySquare.frame.size.width/2.2 startAngle:DEGREES_TO_RADIANS(200) endAngle:DEGREES_TO_RADIANS(300) clockwise:YES];
    CAShapeLayer *shape = [self createShapeLayerWith:upperPath];
    if (_spinnerColor)
    {
        shape.strokeColor = _spinnerColor.CGColor;
    }
    else
    {
        shape.strokeColor = [UIColor whiteColor].CGColor;
    }
    [viewActivitySquare.layer addSublayer:shape];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotationAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self rotationAnimation];
    
    viewActivitySquare.center = CGPointMake(viewNotRotate.frame.size.width/2, viewNotRotate.frame.size.height/2);

    [UIView animateWithDuration:_stopShowingAndDismissingAnimation ? 0.0 : 0.5 animations:^{
        [self setAlpha:1.0];
    }];
}


-(CAShapeLayer*)createShapeLayerWith:(UIBezierPath*)path
{
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    if (_spinnerSize == kSHSpinnerSizeSmall)
    {
        shape.lineWidth = 4.0f;
    }
    else if (_spinnerSize == kSHSpinnerSizeMedium)
    {
        shape.lineWidth = 8.0f;
    }
    else if(_spinnerSize == kSHSpinnerSizeLarge)
    {
        shape.lineWidth = 10.0f;
    }
    else if (_spinnerSize == kSHSpinnerSizeVeryLarge)
    {
        shape.lineWidth = 12.0f;
    }
    shape.lineCap = kCALineCapRound;
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.strokeColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    return shape;
}

-(void)setDisableEntireUserInteraction:(BOOL)disableEntireUserInteraction
{
    if (disableEntireUserInteraction)
    {
        _disableEntireUserInteraction = YES;
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
}

-(void)rotationAnimation
{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:0.0];
    rotate.toValue = [NSNumber numberWithFloat:6.2];
    rotate.repeatCount = CGFLOAT_MAX;
    rotate.duration = 1.5f;
    [viewActivitySquare.layer addAnimation:rotate forKey:@"rotateRepeatedly"];
}

-(void)firstDot:(UILabel*)label
{
    label.text = @".";
    [self performSelector:@selector(secondDot:) withObject:label afterDelay:dotEnteringDelay];
}

-(void)secondDot:(UILabel*)label
{
    label.text = @"..";
    [self performSelector:@selector(thirdDot:) withObject:label afterDelay:dotEnteringDelay];
}

-(void)thirdDot:(UILabel*)label
{
    label.text = @"...";
    [self performSelector:@selector(removeAllDots:) withObject:label afterDelay:dotEnteringDelay];
}

-(void)removeAllDots:(UILabel*)label
{
    label.text = @"";
    [self performSelector:@selector(firstDot:) withObject:label afterDelay:dotEnteringDelay];
}

-(void)dismissAndStopAnimation
{
    [UIView animateWithDuration:_stopShowingAndDismissingAnimation ? 0.0 : 0.5 animations:^{
        [self setAlpha:0.0];
    }completion:^(BOOL finished) {
        if (finished)
        {
            isAnimating = NO;
            for (UIView *view in self.subviews)
            {
                [view removeFromSuperview];
            }
            if (_disableEntireUserInteraction)
            {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        }
    }];
    
}

@end
