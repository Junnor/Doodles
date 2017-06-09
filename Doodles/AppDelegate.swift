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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppAppearance()
        print("didFinishLaunchingWithOptions")
        
        Doodle.configureDynamicShortcuts()
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        print("performActionFor shortcutItem")
        handleShortcutItem(shortcutItem: shortcutItem)
        completionHandler(true)
    }
    
    private func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) {
        switch  shortcutItem.type {
        case "com.razeware.Doodles.new":
            presentNewDoodleViewController()
            case "com.razeware.Doodles.share":
            shareMostRecentDoodle()
        default: break
        }
    }
    
    private func presentNewDoodleViewController() {
        let identifier = "NewDoodleNavigationController"
        let doodleViewController = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: identifier)
        window?.rootViewController?.present(doodleViewController, animated: true, completion: nil)
    }
    
    
    private func shareMostRecentDoodle() {
        guard let mostRecentDoodle = Doodle.sortedDoodles.first, let navigatinController = window?.rootViewController as? UINavigationController else {
            return
        }
        
        let identifier = "DoodleDetailViewController"
        let doodleViewController = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: identifier) as! DoodleDetailViewController
        
        doodleViewController.doodle = mostRecentDoodle
        doodleViewController.shareDoodle = true
        navigatinController.pushViewController(doodleViewController, animated: true)
    }
    
    

}
