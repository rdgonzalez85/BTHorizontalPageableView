//
//  BTHorizontalPageableView.swift
//
//  Created by Rodrigo Gonzalez on 1/21/16.
//  Copyright © 2016 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

/**

The BTHorizontalPageableView class defines a rectangular area on the screen and the interfaces for managing the content in that area.  It provides support for displaying multiple contents as it were only one. It allow users to scroll within that content by making swiping gestures.

 To create a BTHorizontalPageableView  you can use code like the following:

    let btScrollView = BTHorizontalPageableView(frame: frame)

*/
class BTHorizontalPageableView: UIView, YSSegmentedControlDelegate, UIScrollViewDelegate {

    //// The Segmented control, used for display the 'titles' bar.
    var segmentedControl : YSSegmentedControl? {
        didSet {
            oldValue?.removeFromSuperview()
            self.addSubview(segmentedControl!)
            segmentedControl!.delegate = self
            segmentedControl?.appearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            segmentedControl?.appearance.selectorColor = UIColor.whiteColor()
            segmentedControl?.appearance.textColor = UIColor.whiteColor()
            segmentedControl?.appearance.selectedTextColor = UIColor.whiteColor()
        }
    }
    
    //// Indicates if the 'views' should be placed under the 'titles' bar.
    var viewsUnderSegmentedControl  = true {
        didSet {
            if (viewsUnderSegmentedControl != oldValue) {
                var frame = scrollView.frame
                if (viewsUnderSegmentedControl) {
                    frame.origin.y -= segmentedHeight
                } else {
                    frame.origin.y += segmentedHeight
                }
                scrollView.frame = frame
            }
        }
    }
    
    //// Height of the segmented view.
    var segmentedHeight : CGFloat = 44.0
    
    //// Y origin point of the segmented view.
    var segmentedYOrigin : CGFloat = 0.0
    
    //// X origin point of the segmented view.
    var segmentedXOrigin : CGFloat = 0.0
    
    //// The titles of the segments.
    var titles : Array<String>? {
        didSet {
            self.segmentedControl = YSSegmentedControl(
                frame: CGRect(
                    x: self.bounds.origin.x + segmentedXOrigin,
                    y: self.bounds.origin.y + segmentedYOrigin,
                    width: self.frame.width,
                    height: segmentedHeight),
                titles: titles!)
        }
    }

    //// The duration of the animation for scrolling to a new page.
    var scrollViewPageChangeAnimationDuration : NSTimeInterval = 0.5
    
    //// The container for the views.
    var scrollView = UIScrollView()
    
    /// The containing views.
    var views : Array<UIView>? {
        didSet {
            addViews()
        }
    }
    
    override var frame:CGRect {
        didSet {
            scrollView.frame = frame
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        addSubview(self.scrollView)
        setupScrollView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.scrollView)
    }
    
    /**
        Add all the views in 'views' to 'scrollView'
    */
    private func addViews() {
        var x : CGFloat = 0.0
        
        guard let safeViews = views else {
            return
        }
        
        for view in safeViews {
            var frame = view.frame
            frame.origin.x = x
            view.frame = frame
            
            scrollView.addSubview(view)
            x += view.frame.width
        }
        
        scrollView.contentSize = CGSize(width: x, height: scrollView.frame.height)
    }
    
    /**
        Setups 'scrollView'.
        
        Assigns scrollView delegate and set the pagingEnabled property to true.
    */
    private func setupScrollView() {
        scrollView.frame = self.bounds
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    /**
        Scrolls the 'scrollView' to 'page' page.
     
        - Parameter page:  The number of page to scroll to.
     */
    private func scrollToPage(page : Int) {
        guard let safeViews = views
            where page < safeViews.count else {
                return
        }
        
        var frame = scrollView.frame
        frame.origin.x = frame.width * CGFloat(page)
        
        UIView.animateWithDuration(scrollViewPageChangeAnimationDuration, animations: { () -> Void in
            self.scrollView.scrollRectToVisible(frame, animated: false)
        })
    }
    
    //MARK: YSSegmentedControlDelegate
    internal func segmentedControlDidPressedItemAtIndex (segmentedControl: YSSegmentedControl, index: Int) {
        scrollToPage(index)
    }
    
    //MARK: UIScrollViewDelegate
    internal func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let fractionalPage = targetContentOffset.memory.x / scrollView.frame.size.width;
        let page = ceil(fractionalPage)
        
        guard let safeControl = segmentedControl else {
            return
        }
        
        guard let safeTitles = titles
            where Int(page) < safeTitles.count && Int(page) >= 0 else {
                return
        }
        
        safeControl.selectItemAtIndex(Int(page))
    }
}