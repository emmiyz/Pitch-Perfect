//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Emily Zhao on 2/8/16.
//  Copyright © 2016 Emily Zhao. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
