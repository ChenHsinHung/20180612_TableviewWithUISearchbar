//
//  heroTableViewCell.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2018/6/12.
//  Copyright © 2018年 chen hsin hung. All rights reserved.
//

import UIKit


class heroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_heroName: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    
    
    var cellHeroData : HeroDataInfo? = HeroDataInfo()
    var delegate : cellEventDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func assginCelldata (value  : HeroDataInfo){
        self.cellHeroData?.name = value.name
        self.cellHeroData?.voteCount = value.voteCount
        self.cellHeroData?.imageName = value.imageName
        showCelldata()
        
        addImageTapGestureRecognizer()  //加點擊方法
        
        
    }
    
    func addImageTapGestureRecognizer(){
   
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapShowImage(gesture:)))
        headImage.addGestureRecognizer(tap)
        headImage.isUserInteractionEnabled = true
   
    }
    
    @objc func tapShowImage(gesture recognizer:UITapGestureRecognizer) {

        if let herodata = cellHeroData {
            print("tapShowImage \(herodata)")
            delegate?.showimage(sender: herodata)
            
        }
        
    }
    
    
    //顯示資料
    
    func  showCelldata() {
        
        if  let name = cellHeroData?.name! , let  voteCount = cellHeroData?.voteCount! {
            self.lbl_heroName.text = "\(voteCount) ,   \(name)   "
        }
        
        if let  imagename = cellHeroData?.imageName {
            
            if imagename.isEmpty  {return}
            self.headImage.image = UIImage(named: imagename)
        }

    }

    
    
    func  addvote() {
        
        if let voteCount =  cellHeroData?.voteCount {
            cellHeroData?.voteCount = voteCount + 1
  
        }

    }
    
    
    
    @IBAction func actvote(_ sender: Any) {
        
        addvote()
        delegate?.updateVoteCount(cellForRowAt: indexPath!, value: self.cellHeroData!) //執行 update array
        showCelldata()
        
        
        //debug area show console
        if let name = cellHeroData?.name , let voteCount = cellHeroData?.voteCount   {
            print("vote 最新票數\((name ,voteCount)) ")
            
        }
 
        
    }
    
    
}






