//
//  introViewController.swift
//  Swift5IntroApp01
//
//  Created by 中塚富士雄 on 2020/08/26.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import Lottie

class introViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["1","2","3","4","5"]
    
    var onboardStringArray = ["We are the world! ","We are the friends!","We are the children!","We are the human!","We are the citizens of the esrth!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isPagingEnabled = true
        setUpScroll()
        
        for i in 0...4{
            
            let animationView = AnimationView()
            
            //viewのsizeの分だけ、右へいく
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            
            scrollView.addSubview(animationView)
     
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpScroll(){
        
        scrollView.delegate = self
        
        //pagingのために×5（Array内の要素の数）
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: scrollView.frame.size.height)
    
        for i in 0...4{
        
        let onboardLabel = UILabel(frame:CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height/3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        
        onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            scrollView.addSubview(onboardLabel)
        
        }
    
    
    

    }
}
