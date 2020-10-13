//: [Previous](@previous)

import UIKit

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .cyan

extension UIBezierPath {

    /// Create UIBezierPath for regular polygon with rounded corners
    ///
    /// - parameter rect:            The CGRect of the square in which the path should be created.
    /// - parameter sides:           How many sides to the polygon (e.g. 6=hexagon; 8=octagon, etc.).
    /// - parameter lineWidth:       The width of the stroke around the polygon. The polygon will be inset such that the stroke stays within the above square. Default value 1.
    /// - parameter cornerRadius:    The radius to be applied when rounding the corners. Default value 0.

    convenience init(polygonIn rect: CGRect, sides: Int, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 0) {
        self.init()

        let theta = 2 * .pi / CGFloat(sides)                 // how much to turn at every corner
        let offset = cornerRadius * tan(theta / 2)           // offset from which to start rounding corners
        let squareWidth = min(rect.width, rect.height)       // width of the square

        // calculate the length of the sides of the polygon

        var length = squareWidth - lineWidth
        if sides % 4 != 0 {                                  // if not dealing with polygon which will be square with all sides ...
            length = length * cos(theta / 2) + offset / 2    // ... offset it inside a circle inside the square
        }
        let sideLength = length * tan(theta / 2)

        // if you'd like to start rotated 90 degrees, use these lines instead of the following two:
        //
         var point = CGPoint(x: rect.midX - length / 2, y: rect.midY + sideLength / 2 - offset)
         var angle = -CGFloat.pi / 2.0

        // if you'd like to start rotated 180 degrees, use these lines instead of the following two:
        //
        // var point = CGPoint(x: rect.midX - sideLength / 2 + offset, y: rect.midY - length / 2)
        // var angle = CGFloat(0)

//        var point = CGPoint(x: rect.midX + sideLength / 2 - offset, y: rect.midY + length / 2)
//        var angle = CGFloat.pi

        move(to: point)

        // draw the sides and rounded corners of the polygon

        for _ in 0 ..< sides {
            point = CGPoint(x: point.x + (sideLength - offset * 2) * cos(angle), y: point.y + (sideLength - offset * 2) * sin(angle))
            addLine(to: point)

            let center = CGPoint(x: point.x + cornerRadius * cos(angle + .pi / 2), y: point.y + cornerRadius * sin(angle + .pi / 2))
            addArc(withCenter: center, radius: cornerRadius, startAngle: angle - .pi / 2, endAngle: angle + theta - .pi / 2, clockwise: true)

            point = currentPoint
            angle += theta
        }

        close()

        self.lineWidth = lineWidth           // in case we're going to use CoreGraphics to stroke path, rather than CAShapeLayer
        lineJoinStyle = .round
    }

}


func createHexagon(view: UIView) -> UIView {
    let path = UIBezierPath(polygonIn: view.bounds, sides: 6, lineWidth: 5, cornerRadius: 20)
    let shap = CAShapeLayer()
    shap.path = path.cgPath
    view.layer.mask = shap
    
    return view
}

let newView = createHexagon(view: view)

//: [Next](@next)
