//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


// ========== Container view ===================
let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
container.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)

// =============================================
// =========== Ripple Animation ================
// =============================================
let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

// Scale animation
let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
scaleAnimation.duration = 1
scaleAnimation.keyTimes = [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
scaleAnimation.values =   [0.0, 0.4, 0.6, 0.7, 0.8, 0.9, 0.92, 0.94, 0.95, 1]
scaleAnimation.timingFunction = timingFunction

// Opacity animation
let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
opacityAnimation.duration = 1
opacityAnimation.keyTimes = [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
opacityAnimation.values =   [1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.25, 0.1, 0.1, 0]
opacityAnimation.timingFunctions = [timingFunction, timingFunction]

// Animation group with both animation
let animationGroup = CAAnimationGroup()
animationGroup.animations = [scaleAnimation, opacityAnimation]
animationGroup.duration = 1
animationGroup.repeatCount = HUGE

// Drawing the circle
let circle = CAShapeLayer()
let circlePath = UIBezierPath(roundedRect: CGRectMake(0, 0, 40, 40), cornerRadius: 20)

circle.fillColor = nil
circle.lineWidth = 2
circle.strokeColor = UIColor.whiteColor().CGColor
circle.path = circlePath.CGPath

// Setting the circle frame at the center of the view
circle.frame = CGRectMake(
    (container.bounds.size.width - 40) / 2,
    (container.bounds.size.height - 40) / 2,
    40, 40)


// =============================================
// ========= Three dot animation ===============
// =============================================

for(var i = 0; i < 3; i++)
{
    let dot = CALayer()
    dot.frame = CGRectMake(CGFloat(20 * i + 100), 100, 10, 10)
    dot.backgroundColor = UIColor.whiteColor().CGColor
    dot.anchorPoint = CGPointMake(0.5, 0.5);
    dot.cornerRadius = 5
    dot.opacity = 1
    
    let dotScaleAnimation = CAKeyframeAnimation(keyPath: "transform")
    dotScaleAnimation.values = [
        [NSValue(CATransform3D: CATransform3DMakeScale(0.5, 0.5, 0.0))],
        [NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 0.0))]
    ]
    
    let dotAnimation = CAKeyframeAnimation(keyPath: "opacity")
    dotAnimation.keyTimes = [0.0, 0.7]
    dotAnimation.values = [0.25, 1.0]
    
    let dotAnimationGroup = CAAnimationGroup()
    dotAnimationGroup.removedOnCompletion = false;
    dotAnimationGroup.autoreverses = true;
    dotAnimationGroup.beginTime = 0.1 * Double(i)
    dotAnimationGroup.repeatCount = HUGE
    dotAnimationGroup.duration = 1
    dotAnimationGroup.animations = [dotScaleAnimation, dotAnimation]
    dotAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    container.layer.addSublayer(dot)
    dot.addAnimation(dotAnimationGroup, forKey: "animation")
}

//circle.addAnimation(, forKey: "animation")
//
// container.layer.addSublayer(dot)
//
//
XCPlaygroundPage.currentPage.liveView = container
