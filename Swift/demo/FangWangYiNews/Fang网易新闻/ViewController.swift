//
//  ViewController.swift
//  Fang网易新闻
//
//  Created by jhtwl on 16/5/26.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleScrollView: UIScrollView!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    private lazy var titleArray: [String] = ["本地", "热点", "视频", "图片", "游戏", "NBA", "电影"]
    private var lastBtn: UIButton?
    private var btnArray: [UIButton] = Array()
    private let Kscal:CGFloat = 1.3
    private let btnW: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addSubviewsControllers()
        
        initNavigationBar()
        
        initContentScrollView()
    }
    
    private func initContentScrollView() {
        automaticallyAdjustsScrollViewInsets = false
        contentScrollView.contentSize = CGSize(width: CGFloat(titleArray.count) * view.bounds.width, height: view.bounds.height - titleScrollView.bounds.height - 64)
    }
    
    private func initNavigationBar() {
        for (index, value) in titleArray.enumerate() {
            let btn = UIButton()
            btn.setTitle(value, forState: .Normal)
            btn.setTitleColor(UIColor.blueColor(), forState: .Normal)
            btn.frame = CGRect(x: CGFloat(index) * btnW, y: 0, width: btnW, height: titleScrollView.bounds.height)
            titleScrollView.addSubview(btn)
            btn.addTarget(self, action: #selector(ViewController.processTitleBtn(_:)), forControlEvents: .TouchDown)
            btn.tag = index
            btnArray.append(btn)
            if index == 0 {
                self.processTitleBtn(btn)
            }
        }
        titleScrollView.backgroundColor = UIColor.redColor()
        titleScrollView.contentSize = CGSize(width: btnW * CGFloat(titleArray.count), height: titleScrollView.bounds.height)
    }
    
    private func addSubviewsControllers() {
        
        let localVC = LocalViewController()
        addChildViewController(localVC)
        
        let hotVC = HotViewController()
        addChildViewController(hotVC)
        
        let vedioVc = VedioViewController()
        addChildViewController(vedioVc)
        
        let picyureVC = PictureViewController()
        addChildViewController(picyureVC)
        
        let playerVC = PlayerViewController()
        addChildViewController(playerVC)
        
        let nbaVC = NBAViewController()
        addChildViewController(nbaVC)
        
        let movieVC = MovieViewController()
        addChildViewController(movieVC)
        
    }
    
    func processTitleBtn(sender: UIButton) {
        print("index = \(sender.tag)")
        
        if lastBtn != nil {
            lastBtn?.setTitleColor(UIColor.blueColor(), forState: .Normal)
            lastBtn?.transform = CGAffineTransformIdentity
        }
        
        sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
        sender.transform = CGAffineTransformMakeScale(Kscal, Kscal)
        
        let vc = self.childViewControllers[sender.tag]
        
        if !vc.isViewLoaded() {
            vc.view.frame = CGRect(x: view.bounds.width * CGFloat(sender.tag), y: 0, width: view.bounds.width, height: view.bounds.height)
            contentScrollView.addSubview(vc.view)
        }
        
        contentScrollView.contentOffset = CGPoint(x: view.bounds.width * CGFloat(sender.tag), y: 0)
        
        lastBtn = sender
        
        titleBtnChangeOffX(sender.tag)
    }
    
    func titleBtnChangeOffX(index: Int)  {
        
        let btn = btnArray[index]
        var offX = btn.center.x - view.bounds.width * 0.5
        
        if offX < 0 {
            offX = 0
        }
        
        let maxOffx = titleScrollView.contentSize.width - view.bounds.width
        
        if offX > maxOffx {
            offX = maxOffx
        }
        
        print("offX = \(offX)")
//        if btn.center.x != (view.bounds.width * CGFloat(index)) {
            titleScrollView.setContentOffset(CGPoint(x: offX, y: 0), animated: true)
//        }
    }
}


extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("x = \(scrollView.contentOffset.x)")
        
        let currentPage: CGFloat = scrollView.contentOffset.x / view.bounds.width
        
        let leftPage:Int = Int(currentPage)
        let rightPage: Int = Int(currentPage + 1)
        
        var rightBtn: UIButton?
        if rightPage < btnArray.count - 1 {
            rightBtn = btnArray[rightPage]
        }
        let leftBtn = btnArray[leftPage]
//
        let rightScale:CGFloat = currentPage - CGFloat(leftPage)
        let leftScale: CGFloat = 1.0 - rightScale
        
        print("rightScale = \(rightScale), leftScale = \(leftScale)")
        
        let scale: CGFloat = 0.3
        
        leftBtn.transform = CGAffineTransformMakeScale(leftScale * scale + 1, 1 + leftScale * scale)
        rightBtn?.transform = CGAffineTransformMakeScale(rightScale * scale + 1, rightScale * scale + 1)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("滚动完毕")
        let index: Int = Int(scrollView.contentOffset.x / view.bounds.width)
        self.processTitleBtn(btnArray[index])
        
    }
}
