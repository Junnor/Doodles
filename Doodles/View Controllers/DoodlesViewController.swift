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

class DoodlesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("..master self: \(self)")
        tableView.reloadData()
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    @IBAction func unwindToDoodlesViewController(_ segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DoodleDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow, segue.identifier == "ViewDoodleSegue" {
            let doodle = Doodle.allDoodles[indexPath.row]
            destinationViewController.doodle = doodle
        }
    }
}

extension DoodlesViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) as? DoodleCell else {
                return nil
        }
        
        let identifier = "DoodleDetailViewController"
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? DoodleDetailViewController else {
            return nil
        }
        detailVC.doodle = cell.doodle
        detailVC.doodlesViewController = self
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
        
    }
}

//MARK: UITableViewDataSource
extension DoodlesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Doodle.allDoodles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoodleCell", for: indexPath) as! DoodleCell
        
        cell.doodle = Doodle.allDoodles[indexPath.row]
        
        return cell
    }
}


// MARK: - ViewHeadabel protocol

extension DoodlesViewController: ViewHeadabel {
    
    var animatedViewFrame: CGRect {
        
        //        let attribute = collectionView.layoutAttributesForItem(at: collectionView.indexPathsForSelectedItems![0])
        //        let cellRect = attribute?.frame
        
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)
        let cellRect = cell?.frame
        
        let animatedFrame = tableView?.convert((cellRect)!, to: view)
        
        return animatedFrame!
    }
}
