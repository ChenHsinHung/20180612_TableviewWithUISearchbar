//
//  fullImageviewViewController.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2019/8/11.
//  Copyright © 2019 chen hsin hung. All rights reserved.
//

import UIKit

class fullImageviewViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var fullSizeImage: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var herodata : HeroDataInfo? = HeroDataInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        scrollview.delegate = self
        
        self.scrollview.minimumZoomScale = 1
        self.scrollview.maximumZoomScale = 6
        
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullSizeImage
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        if let herodata = herodata {
            self.fullSizeImage.image = UIImage(named: herodata.imageName!)
            self.navigationItem.title = herodata.name!
            
        }
        
        
//        if let imagename = herodata?.imageName {
//            self.fullSizeImage.image = UIImage(named: imagename)
//
//        }
        
//        self.navigationItem.title = herodata?.name
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
