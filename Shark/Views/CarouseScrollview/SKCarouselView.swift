//
//  SKCarouselView.swift
//  CarouselDemo
//
//  Created by Dalang on 2017/3/7.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

@objc protocol SKCarouselViewDelegate {
    
    func sizeForPage(inCarouselView carouselView: SKCarouselView) -> CGSize
    
    @objc optional func carouselView(_ carouselView: SKCarouselView, didScrollToPage page: Int)
    
    @objc optional func carouselView(_ carouselView: SKCarouselView, didSelectPageAtIndex index: Int)
    
}

protocol SKCarouselViewDataSource: class {
    
    func numberOfPages(inCarouselView carouselView: SKCarouselView) -> Int
    
    func carouselView(_ carouselView: SKCarouselView, cellForPageAtIndex index: Int) -> SKCarouselCell
}

final class SKCarouselView: UIView {

    weak var delegate: SKCarouselViewDelegate?
    weak var dataSource: SKCarouselViewDataSource?
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    } ()
    fileprivate var containerViews: [SKCarouselSubview] = [SKCarouselSubview]()
    fileprivate var currentPageIndex: Int!
    weak fileprivate var timer: Timer?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, dataSource: SKCarouselViewDataSource?, delegate: SKCarouselViewDelegate?) {
        
        super.init(frame: frame)
        
        self.delegate = delegate
        self.dataSource = dataSource
        
        self.clipsToBounds = true
        
        
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self)
            
        }
        
        setup()
        startScroll()
    }
    
    /// 刷新
    func reloadData() {
        stopScroll()
        setup()
        startScroll()
    }
    
    /// 开始滚动
    func startScroll() {
        guard let pageCount = dataSource?.numberOfPages(inCarouselView: self) else {
            return
        }
        
        if pageCount > 1 && timer == nil {
            let middleContainerView: SKCarouselSubview = containerViews[2]
            
            for index in 0..<middleContainerView.containerView.subviews.count {
                let carouselCell = middleContainerView.containerView.subviews[index] as! SKCarouselCell
                
                timer = Timer.scheduledTimer(timeInterval: carouselCell.showTime, target: self, selector: #selector(autoNextPage), userInfo: nil, repeats: true)
            }
        }
        
    }
    
    /// 结束滚动
    func stopScroll() {
        timer?.invalidate()
        timer = nil
    }

}

// MARK: - Private Method
extension SKCarouselView {
    
    
    
    /// 设置界面
    fileprivate func setup() {
        
        currentPageIndex = 0
                
        for (_, subView) in scrollView.subviews.enumerated() {
            subView.removeFromSuperview()
        }
        
        containerViews.removeAll()
        
        
        guard let pageCount = dataSource?.numberOfPages(inCarouselView: self) else {
            return
        }
        
        if pageCount == 0 {
            return;
        }
        
        guard let pageSize = delegate?.sizeForPage(inCarouselView: self) else {
            return
        }
        
        if pageSize == CGSize.zero {
            return
        }
        
        scrollView.frame = CGRect(x: (self.bounds.size.width - pageSize.width) / 2, y: 0, width: pageSize.width, height: pageSize.height)
        scrollView.contentSize = CGSize(width: pageSize.width * 5, height: pageSize.height)
        
        for index in 0..<5 {
            let carousSubView: SKCarouselSubview = SKCarouselSubview(frame: CGRect(x: (CGFloat(index) * pageSize.width), y: 0, width: pageSize.width, height: pageSize.height))
            carousSubView.tag = index + 10
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(singleCellTapAction(_:)))
            carousSubView.addGestureRecognizer(tap)
            
            containerViews.append(carousSubView)
            scrollView.addSubview(carousSubView)
            
            if let carousCell = dataSource?.carouselView(self, cellForPageAtIndex: (pageCount + (currentPageIndex + index - 2)) % pageCount ) {
                carousCell.frame = carousSubView.bounds;
                carousSubView.containerView.addSubview(carousCell)
            }
        }
        
        scrollView.contentOffset = CGPoint(x: pageSize.width * 2, y: 0)
        
    }
    
    /// SKCarouselSubview 点击手势
    ///
    /// - Parameter tap: UITapGestureRecognizer
    @objc fileprivate func singleCellTapAction(_ tap: UITapGestureRecognizer) {
        
        guard let tag = tap.view?.tag else {
            return
        }
        
        guard let pageCount = dataSource?.numberOfPages(inCarouselView: self) else {
            return
        }
        
        if tag - 10 - 2 < 0 {
            delegate?.carouselView!(self, didSelectPageAtIndex: ((currentPageIndex - 1) + pageCount) % pageCount)
        } else if tag - 10 - 2 > 0 {
            delegate?.carouselView!(self, didSelectPageAtIndex: (currentPageIndex + 1) % pageCount)
        } else {
            delegate?.carouselView!(self, didSelectPageAtIndex: currentPageIndex)
        }
        
        
    }
    
    /// 自动滚动
    @objc fileprivate func autoNextPage() {
        guard let pageSize = delegate?.sizeForPage(inCarouselView: self) else {
            return
        }
        scrollView.setContentOffset(CGPoint(x: 3 * pageSize.width, y: 0), animated: true)
    }
    
    /// override hitTest
    ///
    /// - Parameters:
    ///   - point: point
    ///   - event: event
    /// - Returns: UIView?
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.point(inside: point, with: event) {
            let newPoint: CGPoint = scrollView.convert(point, from: self)
            for index in 0..<scrollView.subviews.count {
                let subView = scrollView.subviews[index] as! SKCarouselSubview
                    if subView.frame.contains(newPoint) {
                        let newSubViewPoint = subView.convert(point, from: self)
                        return subView.hitTest(newSubViewPoint, with: event)
                    }
                }
            }
        
            return nil
        }
        
    
        
}


// MARK: - UIScrollViewDelegate
extension SKCarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView === self.scrollView {
            
            guard let pageCount = dataSource?.numberOfPages(inCarouselView: self) else {
                return
            }
            
            if pageCount == 0 {
                return
            }
            
            guard let pageSize = delegate?.sizeForPage(inCarouselView: self) else {
                return
            }
            
            // 向手指向右滑动一个单位,需要删除最后的一个cell，前面添加一个cell
            if scrollView.contentOffset.x <= pageSize.width {
                
                self.stopScroll()
                // 删除第最后一个cell
                self.containerViews.last?.removeFromSuperview()
                self.containerViews.removeLast()
                // 将剩下的cell都向右移动一个cell宽度的位置
                for index in 0..<self.containerViews.count {
                    
                    let carouselSubview: SKCarouselSubview = self.containerViews[index]
                    carouselSubview.frame = CGRect(x: CGFloat(index + 1) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
                    carouselSubview.tag = index + 1 + 10
                }
                // 创建一个新的cell放在最前面
                let carouselSubview: SKCarouselSubview = SKCarouselSubview(frame: CGRect(x: pageSize.width, y: 0, width: pageSize.width, height: pageSize.height))
                
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleCellTapAction(_:)))
                carouselSubview.addGestureRecognizer(tap)
                carouselSubview.tag = 10
                
                containerViews.insert(carouselSubview, at: 0)
                scrollView.addSubview(carouselSubview)
                // 这里使用 _currentPageIndex - 1 - 2 是因为 此时 _currentPageIndex 还未更新为最新的，_currentPageIndex - 1 为最新的位置，之前的第二个位置添加
                if let carousCell = dataSource?.carouselView(self, cellForPageAtIndex: (pageCount + (currentPageIndex - 1 - 2)) % pageCount) {
                    carousCell.frame = carouselSubview.bounds;
                    carouselSubview.containerView.addSubview(carousCell)
                }
                // 重新置中
                scrollView.contentOffset = CGPoint(x: pageSize.width * 2, y: 0)
                
                currentPageIndex = ((currentPageIndex - 1) + pageCount) % pageCount

                delegate?.carouselView!(self, didScrollToPage: currentPageIndex)
                
                self.startScroll()
            }
            // 手指向左滑动一个单位，需要删除最前面的一个cell，最后添加一个cell
            if scrollView.contentOffset.x >= pageSize.width * 3 {
                
                self.stopScroll()
                // 删除第一个cell
                self.containerViews.first?.removeFromSuperview()
                self.containerViews.remove(at: 0)
                // 将剩下的cell都向左移动一个cell宽度的位置
                for index in 0..<containerViews.count {
                    let carouselSubView = containerViews[index]
                    carouselSubView.frame = CGRect(x: CGFloat(index) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
                    carouselSubView.tag = index + 10
                }
                // 创建一个新的cell放在最后面
                let carouselSubview: SKCarouselSubview = SKCarouselSubview(frame: CGRect(x: 4.0 * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height))
                
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleCellTapAction(_:)))
                carouselSubview.addGestureRecognizer(tap)
                carouselSubview.tag = 10 + 4
                
                containerViews.append(carouselSubview)
                scrollView.addSubview(carouselSubview)
                // 这里使用 _currentPageIndex + 1 + 2 是因为 此时 _currentPageIndex 还未更新为最新的，_currentPageIndex + 1 为最新的位置，之后的第二个位置添加
                if let carousCell = dataSource?.carouselView(self, cellForPageAtIndex:(currentPageIndex + 1 + 2) % pageCount) {
                    carousCell.frame = carouselSubview.bounds;
                    carouselSubview.containerView.addSubview(carousCell)
                }
                // 重新置中
                scrollView.contentOffset = CGPoint(x: pageSize.width * 2, y: 0)
                
                currentPageIndex = (currentPageIndex + 1) % pageCount
                
                delegate?.carouselView!(self, didScrollToPage: currentPageIndex)
                
                self.startScroll()

                
            }
        }
    }

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView === self.scrollView {
            self.stopScroll()
        }
    }
    
    
}






































