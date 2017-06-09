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


class DoodleDetailViewController: UIViewController {
    
    weak var doodlesViewController: DoodlesViewController?
    
    var doodle: Doodle?
    var shareDoodle = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    
    fileprivate var activityViewController: UIActivityViewController? {
        guard let doodle = doodle,
            let image = doodle.image else { return nil }
        
        return UIActivityViewController(activityItems: [image], applicationActivities: nil)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let shareActin = UIPreviewAction(title: "Share", style: .default) { (previewAction, viewController) in
            if let doodlesVC = self.doodlesViewController,
                let activityViewController = self.activityViewController {
                doodlesVC.present(activityViewController, animated: true, completion: nil)
            }
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (previewAction, viewController) in
            guard let doodle = self.doodle else {
                return
            }
            Doodle.deleteDoodle(doodle)
            if let doodlesViewController = self.doodlesViewController {
                doodlesViewController.tableView.reloadData()
            }
        }
        
        let test = UIPreviewAction(title: "Test", style: .selected) { (previewAction, viewController) in
            print("view controller = \(viewController)")
        }
        return [shareActin, deleteAction, test]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail view did load self: \(self)")
        if let doodle = doodle {
            title = doodle.name
            imageView.image = doodle.image
        }


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("detail view did appear")
        
        if shareDoodle == true {
            presentActivityViewController()
        }
    }
    
    @IBAction func presentActivityViewController() {
        if let activityViewController = activityViewController {
            present(activityViewController, animated: true, completion: nil)
        }
    }
}
