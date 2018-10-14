//
//  BaseViewController.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarHeight: NSLayoutConstraint!
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: StoryBoardNameConstant.main, bundle: Bundle.main)
    }
    
    func showLoadingIndicator(parent: UIView?) {
        guard activityIndicator == nil, let parentView = parent else {
            activityIndicator?.startAnimating()
            return
        }
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator?.center = parentView.center
        activityIndicator?.hidesWhenStopped = true
        
        guard let activityIndicatorView = activityIndicator else { return }
        parentView.addSubview(activityIndicatorView)
        activityIndicator?.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator?.stopAnimating()
    }
    
    func setUpNavigationBar() { }
}
