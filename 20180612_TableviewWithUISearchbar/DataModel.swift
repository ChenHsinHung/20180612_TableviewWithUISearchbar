//
//  DataModel.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2018/7/29.
//  Copyright © 2018年 chen hsin hung. All rights reserved.
//

import Foundation
import UIKit

//宣告 Cell 各種事件代理
protocol cellEventDelegate {
    
    func showimage( sender : HeroDataInfo )
    func updateVoteCount(cellForRowAt indexPath: IndexPath , value : HeroDataInfo)
}


struct HeroDataInfo {
    var name : String?
    var voteCount : Int? 
    var imageName : String?
    
    init(name : String , voteCount : Int = 0 , imageName : String) {
        self.name = name
        self.voteCount = voteCount
        self.imageName = imageName
    }
    
    init() {
        name = ""
        voteCount = 0
        imageName = nil
    }
}
