//
//  RecommendViewController.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/27.
//

import UIKit

class RecommendViewController: UIViewController, UIScrollViewDelegate {
        
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var pageControl: UIPageControl!
        
        let images: [UIImage] = [UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!,
                                 UIImage(named: "image4")!,
                                 UIImage(named: "image5")!]
        
        var currentIndex = 0
        var timer: Timer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            scrollView.delegate = self
            configureScrollView()
            configurePageControl()
            startTimer()
        }
        
        func configureScrollView() {
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            
            let imageWidth = scrollView.frame.width
            let imageHeight = scrollView.frame.height
            
            scrollView.contentSize = CGSize(width: imageWidth * CGFloat(images.count), height: imageHeight)
            
            for (index, image) in images.enumerated() {
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: CGFloat(index) * imageWidth, y: 0, width: imageWidth, height: imageHeight)
                imageView.contentMode = .scaleAspectFit
                scrollView.addSubview(imageView)
            }
        }
        
        func configurePageControl() {
            pageControl.numberOfPages = images.count
            pageControl.currentPage = 0
        }
        
        func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        }
        
        @objc func scrollToNextPage() {
            let nextPage = (currentIndex + 1) % images.count
            let contentOffsetX = CGFloat(nextPage) * scrollView.frame.width
            scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
            currentIndex = pageControl.currentPage
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            timer?.invalidate()
            timer = nil
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            startTimer()
        }
    }
