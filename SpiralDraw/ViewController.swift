//
//  ViewController.swift
//  SpiralDraw
//
//  Created by devendra narain on 19/01/22.
//

import UIKit

class ViewController: UIViewController {
    let spiralShape1 = CAShapeLayer()
    let spiralShape2 = CAShapeLayer()
    let π = Double.pi
    var bounds = CGRect()
    var center = CGPoint()
    var radius = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        bounds = view.bounds

        clockwiseSpiral()
        counterclockwiseSpiral()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup the clockwise spiral settings
    func clockwiseSpiral(){

        var startAngle:CGFloat = 3*π/2
        var endAngle:CGFloat = 0

        center = CGPoint(x:bounds.width/3, y: bounds.height/3)

        // Setup the initial radius
        radius = bounds.width/90

        // Use UIBezierPath to create the CGPath for the layer
        // The path should be the entire spiral

        // 1st arc
        let linePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        // 2 - 9 arcs
        for _ in 2..<10 {

            startAngle = endAngle

            switch startAngle {
            case 0, 2*π:
                center = CGPoint(x: center.x - radius/2, y: center.y)
                endAngle = π/2
            case π:
                center = CGPoint(x: center.x + radius/2, y: center.y)
                endAngle = 3*π/2
            case π/2:
                center = CGPoint(x: center.x  , y: center.y - radius/2)
                endAngle = π
            case 3*π/2:
                center = CGPoint(x: center.x, y: center.y + radius/2)
                endAngle = 2*π
            default:
                center = CGPoint(x:bounds.width/3, y: bounds.height/3)
            }

            radius = 1.5 * radius
            linePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: true)
        }

        // Setup the CAShapeLayer with the path, line width and stroke color
        spiralShape1.position = center
        spiralShape1.path = linePath.cgPath
        spiralShape1.lineWidth = 6.0
        spiralShape1.strokeColor = UIColor.random().cgColor
        spiralShape1.bounds = spiralShape1.path!.boundingBox
        spiralShape1.fillColor = UIColor.clear.cgColor

        // Add the CAShapeLayer to the view's layer's sublayers
        view.layer.addSublayer(spiralShape1)

        // Animate drawing
        drawLayerAnimation(layer: spiralShape1)

    }

    // Setup the ounterclockwise spiral settings
    func counterclockwiseSpiral(){

        var startAngle:CGFloat = 3*π/2
        var endAngle:CGFloat = π

        center = CGPoint(x:bounds.width/3 + bounds.width/3, y: bounds.height/3)

        // Setup the initial radius
        radius = bounds.width/90

        // Use UIBezierPath to create the CGPath for the layer
        // The path should be the entire spiral

        // 1st arc
        let linePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        // 2 - 9 arcs
        for _ in 2..<10 {

            startAngle = endAngle

            switch startAngle {
            case 0:
                center = CGPoint(x: center.x - radius/2, y: center.y)
                endAngle = 3*π/2
            case π:
                center = CGPoint(x: center.x + radius/2, y: center.y)
                endAngle = π/2
            case π/2:
                center = CGPoint(x: center.x , y: center.y - radius/2)
                endAngle = 0
            case 3*π/2:
                center = CGPoint(x: center.x, y: center.y + radius/2)
                endAngle = π
            default:
                center = CGPoint(x:bounds.width/3 + bounds.width/3, y: bounds.height/3)
            }

            radius = 1.5 * radius
            linePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: false)
        }

        // Setup the CAShapeLayer with the position, path, line width and stroke color
        spiralShape2.position = center
        spiralShape2.path = linePath.cgPath
        spiralShape2.lineWidth = 6.0
        spiralShape2.strokeColor = UIColor.random().cgColor
        spiralShape2.bounds = spiralShape2.path!.boundingBox
        spiralShape2.fillColor = UIColor.clear.cgColor

        // Add the CAShapeLayer to the view's layer's sublayers
        view.layer.addSublayer(spiralShape2)

        // Animate drawing
        drawLayerAnimation(layer: spiralShape2)

    }

    func drawLayerAnimation(layer: CAShapeLayer!){

        let layerShape = layer

        // The starting point
        layerShape?.strokeStart = 0.0

        // Don't draw the spiral initially
        layerShape?.strokeEnd = 0.0

        // Animate from 0 (no spiral stroke) to 1 (full spiral path)
        let drawAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        drawAnimation.duration = 1.6
        drawAnimation.fillMode = .forwards
        drawAnimation.isRemovedOnCompletion = false
        layerShape?.add(drawAnimation, forKey: nil)

    }
    
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
