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
import Photos


class NewDoodleViewController: UIViewController {
    
    fileprivate var canvas: Canvas {
        return view as! Canvas
    }
    @IBAction func clean(_ sender: Any) {
        canvas.erase()
    }
    
    @IBAction func saveTapped() {
        let alert = UIAlertController(title: "Name it!",
                                      message: "What would you like to name your masterpiece?",
                                      preferredStyle: .alert)
        
//        alert.addTextField { textField in
//            textField.autocapitalizationType = .words
//        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
//            let name = alert.textFields!.first!.text!
//            let doodleImage = self.canvas.image
//            let doodle = Doodle(name: name, date: Date(), image: doodleImage)
//            
//            Doodle.addDoodle(doodle)
//            
//            self.dismiss(animated: true, completion: nil)
            
            //
            
            
            let image = UIImage(view: self.view)
            
            PHPhotoLibrary.shared().performChanges( {PHAssetChangeRequest.creationRequestForAsset(from: image) }, completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0);
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}


