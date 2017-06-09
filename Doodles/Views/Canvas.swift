/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@IBDesignable
open class Canvas : UIView {
  
  var image: UIImage? {
    return drawing
  }
  
  fileprivate var drawing: UIImage?
  
  @IBInspectable
  open var strokeWidth: CGFloat = 4.0
  
  @IBInspectable
  open var strokeColor = UIColor.hotPinkColor()
}

extension Canvas {
  open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
        if traitCollection.forceTouchCapability == .available {
            addLineFromPoint(touch.previousLocation(in: self),
                             toPoint: touch.location(in: self),
                             withForce: touch.force)
        } else {
            addLineFromPoint(touch.previousLocation(in: self),
                             toPoint: touch.location(in: self))
        }
    }
  }
}

extension Canvas {
    fileprivate func addLineFromPoint(_ from: CGPoint, toPoint: CGPoint, withForce force: CGFloat = 1) {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
    
    drawing?.draw(in: bounds)
    
    let cxt = UIGraphicsGetCurrentContext()
    cxt?.move(to: CGPoint(x: from.x, y: from.y))
    cxt?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
    
    cxt?.setLineCap(.round)
    
    cxt?.setLineWidth(force * force * strokeWidth)
    
    strokeColor.setStroke()
    
    cxt?.strokePath()
    
    drawing = UIGraphicsGetImageFromCurrentImageContext()
    
    layer.contents = drawing?.cgImage
    
    UIGraphicsEndImageContext()
  }
  
}
