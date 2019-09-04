//
//  mydefineCell.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2019/8/17.
//  Copyright © 2019 chen hsin hung. All rights reserved.
//

import UIKit

class mydefineCell: UITableViewCell {


    @IBOutlet weak var lbl_heroName: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var voteButton: UIButton!
    

    var cellHeroData : HeroDataInfo? = HeroDataInfo()
    var delegate : cellEventDelegate?
    var timer: Timer?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setCellData (value : HeroDataInfo){
        self.cellHeroData?.name = value.name
        self.cellHeroData?.voteCount = value.voteCount
        self.cellHeroData?.imageName = value.imageName
        updateUI()
        
        addImageTapGestureRecognizer()  //加點擊方法
//        addLongPress()    // 長按
    }
    
    func addImageTapGestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapShowImage(gesture:)))
        headImage.addGestureRecognizer(tap)
        headImage.isUserInteractionEnabled = true    //開啟交互有效，點擊有反應。
        
        
    }
    
    @objc func tapShowImage(gesture recognizer:UITapGestureRecognizer) {
        
        if let herodata = cellHeroData {
            print("tapShowImage \(herodata)")
            delegate?.showimage(sender: herodata)
            
        }
        
    }
    
    func addLongPress()  {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))  //Long function will call when user long press on button.
        longGesture.numberOfTapsRequired  = 1
        longGesture.minimumPressDuration = 1.0
        voteButton.addGestureRecognizer(longGesture)
    }
    
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
   
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
                guard let _ = self.timer else { return }
                self.incraseVoteCount()
                self.updateUI()
                 print("gesture.state == .began")
            }
        }
        
        if gesture.state == .ended {
            timer?.invalidate()
            print("timer?.invalidate()")
            
        }

    }

    
    //顯示資料
    func  updateUI() {
        
        if  let name = cellHeroData?.name! , let  voteCount = cellHeroData?.voteCount! {
            self.lbl_heroName.text = "\(voteCount) ,   \(name)   "
        }
        
        if let  imagename = cellHeroData?.imageName {
            
            if imagename.isEmpty  {return}
            self.headImage.image = UIImage(named: imagename)
        }

    }

    func  incraseVoteCount() {
        if let voteCount =  cellHeroData?.voteCount {
            cellHeroData?.voteCount = voteCount + 1
            
        }
    }
    
    @IBAction func actvote(_ sender: Any) {
        
        incraseVoteCount()
        delegate?.updateVoteCount(cellForRowAt: indexPath!, value: self.cellHeroData!) //執行 update array
        updateUI()
    
        //debug area show console
        if let name = cellHeroData?.name , let voteCount = cellHeroData?.voteCount   {
            print("vote 最新票數\((name ,voteCount)) ")
            
        }
        
        
    }
    
    
}

