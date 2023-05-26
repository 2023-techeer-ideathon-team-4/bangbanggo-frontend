//
//  MoreViewController.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/27.
//

import UIKit

class MoreViewController: UIViewController {

    
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var pageControl: UIPageControl!
    
    var websites = [
           "ktourtop10.kr", "expedia.co.kr", "kr.trip.com", "korean.visitkorea.or.kr","verygoodtour.com"]
        var websitesImages = [
            UIImage(named: "테마10선"),
            UIImage(named: "트릿닷컴"),
            UIImage(named: "대한민국구석구석"),
            UIImage(named: "트릿닷컴"),
            UIImage(named: "트릿닷컴")
        ]
        var currentCellIndex = 0
        var timer: Timer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.delegate = self
            collectionView.dataSource = self
            pageControl.numberOfPages = websitesImages.count
            
            collectionView.register(UINib(nibName: "ExtensionHomeTravelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExtensionHomeTravelCollectionViewCell")
            
            startTimer()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            stopTimer()
        }
        
        func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        @objc func changeImage() {
            currentCellIndex += 1
            if currentCellIndex >= websitesImages.count {
                currentCellIndex = 0
            }
            
            collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentCellIndex
        }
    }

    extension MoreViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return websitesImages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExtensionHomeTravelCollectionViewCell", for: indexPath) as! ExtensionHomeTravelCollectionViewCell
            cell.images.image = websitesImages[indexPath.item]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            let collectionViewHeight = collectionView.bounds.height
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "WebsiteViewController") as! WebsiteViewController
            vc.websites = websites
            vc.currentWebsite = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

