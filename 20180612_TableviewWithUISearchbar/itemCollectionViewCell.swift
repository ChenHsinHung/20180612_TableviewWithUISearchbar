//
//  itemCollectionViewCell.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2019/8/20.
//  Copyright © 2019 chen hsin hung. All rights reserved.
//

import UIKit

class itemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    
     var cellHeroData : HeroDataInfo? = HeroDataInfo()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setCellData (value : HeroDataInfo){
        self.cellHeroData?.name = value.name
        self.cellHeroData?.voteCount = value.voteCount
        self.cellHeroData?.imageName = value.imageName
        updateUI()
        


    }
    
    
    
    //顯示資料
    func  updateUI() {
        
//        if  let name = cellHeroData?.name! , let  voteCount = cellHeroData?.voteCount! {
//        }
        
        if let  imagename = cellHeroData?.imageName {
            
            if imagename.isEmpty  {return}
            self.heroImage.image = UIImage(named: imagename)
        }
        
    }
    

}
