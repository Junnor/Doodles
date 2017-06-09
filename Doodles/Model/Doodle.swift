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

struct Doodle {
    let name: String
    let date: Date
    let image: UIImage?
    
    static var allDoodles = [
        Doodle(name: "Doggy", date: Date(), image: UIImage(named: "doodle1")),
        Doodle(name: "Razeware", date: Date(), image: UIImage(named: "doodle2")),
        Doodle(name: "House", date: Date(), image: UIImage(named: "doodle3"))
    ]
    
    static var sortedDoodles: [Doodle] {
        return allDoodles.sorted { $0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow }
    }
    
    static func addDoodle(_ doodle: Doodle) {
        allDoodles.append(doodle)
        configureDynamicShortcuts()
    }
    
    static func deleteDoodle(_ doodle: Doodle) {
        if let index = allDoodles.index(where: { $0.name == doodle.name }) {
            allDoodles.remove(at: index)
        }
        configureDynamicShortcuts()
        
        
//        if let index = allDoodles.index(where: { $0.name == doodle.name }) {
//        }
    }
    
    static func configureDynamicShortcuts() {
        if let mostRecentDoodle = Doodle.sortedDoodles.first {
            let shortcutType = "com.razeware.Doodles.share"
            let shortcutItem = UIApplicationShortcutItem(type: shortcutType, localizedTitle: "Share Latest Doodle", localizedSubtitle: mostRecentDoodle.name, icon: UIApplicationShortcutIcon(type: .share), userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem]
        } else {
            UIApplication.shared.shortcutItems = []
        }
    }
    
}
