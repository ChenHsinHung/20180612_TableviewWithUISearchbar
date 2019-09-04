//
//  Static_constant_file.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2019/8/15.
//  Copyright © 2019 chen hsin hung. All rights reserved.
//

import Foundation


struct xib_CellInfo {
    var xibName : String?
    var cellID  : String?
    
    init( _xibName : String , _cellID : String) {
        self.cellID = _cellID
        self.xibName = _xibName
    }
    
    init() {
        self.xibName = ""
        self.cellID = ""
    }
    

}

struct SegueID {
//    static let topicPicker = "TopicPickerController"
//    static let mainShowDetail = "ShowDetail"
//    static let mainAddNew = "AddNew"
    static let fullImage = "fullimage_segue"
    
}


struct StoryboardID {
    static let main = "Main"
    static let mainNC = "MainNC"
    static let zoneNC = "ZoneNC"
    static let note = "Note"
    static let noteNC = "NoteNC"
}
