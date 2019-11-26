//
//  OnBoardViewController.swift
//  OompaLoompa
//
//  Created by Mariana Beilune Abad on 25/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class OnBoardViewController: UIPageViewController {
    
    private var pageControl = UIPageControl(frame: .zero)

    private func setupPageControl() {

        pageControl.numberOfPages = pages.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)

        let leading = NSLayoutConstraint(item: pageControl, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: pageControl, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)

        view.insertSubview(pageControl, at: 0)
        view.bringSubviewToFront(pageControl)
        view.addConstraints([leading, trailing, bottom])
    }
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "roxo"),
            self.getViewController(withIdentifier: "verde"),
            self.getViewController(withIdentifier: "azul")
        ]
    }()
        
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataSource = self
            self.delegate = self
            setupPageControl()
            
            if let firstVC = pages.first
            {
                setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
        
}

extension OnBoardViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return pages.last }
        
        guard pages.count > previousIndex else { return nil }
        
        pageControl.currentPage = previousIndex
        return pages[previousIndex]
        print(previousIndex)

    
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil}
        
        pageControl.currentPage = nextIndex
        return pages[nextIndex]
        print(nextIndex)

    }
}

extension OnBoardViewController: UIPageViewControllerDelegate { }
