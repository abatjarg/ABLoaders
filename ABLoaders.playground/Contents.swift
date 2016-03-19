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

circle.addAnimation(animationGroup, forKey: "animation")

container.layer.addSublayer(circle)


XCPlaygroundPage.currentPage.liveView = container
