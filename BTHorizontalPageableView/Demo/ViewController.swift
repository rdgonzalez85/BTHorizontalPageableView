//
//  ViewController.swift
//  BTHorizontalScrollview
//
//  Created by Belatrix on 1/21/16.
//  Copyright © 2016 batasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var views = Array<UIView>()
        var titles = Array<String>()
        
        for i in 1...5 {
            let view = UIView(frame: CGRectZero)
            view.backgroundColor = getRandomColor()
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            views.append(view)
            titles.append(String(i))
        }
        
        let offset : CGFloat = 20
        
        var frame = self.view.frame
        frame.origin.y = offset
        frame.size.height = self.view.frame.height - offset
        
        let btScrollView = BTHorizontalPageableView(frame: frame)
        btScrollView.viewsUnderSegmentedControl = false
        btScrollView.views = views
        btScrollView.titles = titles
        
        self.view.addSubview(btScrollView)
        
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

