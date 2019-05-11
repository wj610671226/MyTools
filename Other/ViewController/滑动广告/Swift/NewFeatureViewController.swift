//
//  NewFeatureViewController.swift
//  MeishanNewlife
//
//  Created by jhtwl on 16/10/25.
//  Copyright © 2016年 chenjing. All rights reserved.
//

import UIKit

class NewFeatureViewController: UIViewController ,UIScrollViewDelegate {

    /// 图片名字
    private let imageNames:[String] = ["newFeature.png", "newFeature1.png", "newFeature2.png", "newFeature3.png"]
    
    private var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加ScrollView
        addScrollView()
        
        // 添加UIPageControl
        addPageControl()
    }

    private func addScrollView() {
        let imageCount = imageNames.count

        // 添加ScrollView
        let newFeatureScrollView = UIScrollView.init(frame: UIScreen.mainScreen().bounds)
        view.addSubview(newFeatureScrollView)
        newFeatureScrollView.contentSize = CGSizeMake(ScreenWidth * CGFloat(imageCount), ScreenHeight)
        newFeatureScrollView.bounces = false
        newFeatureScrollView.pagingEnabled = true
        newFeatureScrollView.showsHorizontalScrollIndicator = false
        newFeatureScrollView.delegate = self
        
        // 添加imageView
        for index in 0..<imageNames.count {
            let imageView = UIImageView()
            imageView.userInteractionEnabled = true
            imageView.image = UIImage.init(named: imageNames[index])
            imageView.frame = CGRect(x: ScreenWidth * CGFloat(index), y: 0, width: ScreenWidth, height: ScreenHeight)
            newFeatureScrollView.addSubview(imageView)
            
            // 最后一张图片上面添加进入应用按钮
            if (index == imageCount - 1) {
                let beginBtn = UIButton()
                beginBtn.frame = CGRectMake(0, 0, 100, 30);
                beginBtn.addTarget(self, action: #selector(NewFeatureViewController.processBeginBtn), forControlEvents: .TouchDown)
                beginBtn.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 5 * 4)
                beginBtn.setTitle("进入应用", forState: .Normal)
                beginBtn.setBackgroundImage(UIImage.init(named: "newFeature_back.png"), forState: .Normal)
                beginBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                beginBtn.layer.cornerRadius = 15
                beginBtn.clipsToBounds = true
                imageView.addSubview(beginBtn)
            }
        }
    }
    
    private func addPageControl() {
        // 添加
        pageControl = UIPageControl()
        pageControl.frame = CGRectMake(0, 0, 80, 20);
        pageControl.numberOfPages = imageNames.count;
        pageControl.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 7 * 6);
        view.addSubview(pageControl)
        
        // 设置颜色
        pageControl.currentPageIndicatorTintColor = UIColor(red: 253 / 255.0, green: 98 / 255.0, blue: 42 / 255.0, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(red: 189 / 255.0, green: 189 / 255.0, blue: 189 / 255.0, alpha: 1)
    }
    
    func processBeginBtn() {
        let currentVersion = NSBundle.mainBundle().infoDictionary![CurrentVersionKey]
        NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: CurrentVersionKey)
        view.window?.rootViewController = AdvViewController();
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 1.取出水平方向上滚动的距离
        let offsetX: CGFloat = scrollView.contentOffset.x;
        
        // 2.求出页码
        let pageDouble: Double = Double(offsetX / ScreenWidth);
        let pageInt: Int = Int(pageDouble + 0.5);
        pageControl.currentPage = pageInt;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
