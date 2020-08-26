//
//  introViewController.swift
//  Swift5IntroApp01
//
//  Created by 中塚富士雄 on 2020/08/26.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import Lottie

class introViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["1","2","3","4","5"]
    
    var onboardAtringArray = ["We are the world! ","We are the friends!","We a the children!","We are the human!","We are the citizen!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isPagingEnabled = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpScroll(){
        
        
        
    }
    
    
    

}
