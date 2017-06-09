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

extension AppDelegate {
  func configureAppAppearance()  {
    UIApplication.shared.delegate?.window??.tintColor = UIColor.hotPinkColor()
    
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = UIColor.hotPinkColor()
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]
  }
}

extension UIStoryboard {
  class var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
}

extension UINavigationController {
  open override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
}

extension UIColor {
  class func hotPinkColor() -> UIColor { return UIColor(red:0.98, green:0.066, blue:0.309, alpha:1) }
}