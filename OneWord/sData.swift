//
//  pdata.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-16.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

private let sharedInstance = sData()

class sData {
    static let sharedInstance = sData()
    var imageTaken:UIImage?
    var didLoad = false
    var stickerArr: [sticker] = []
    var tagsArr: [String] = []
    class var sharedDispatchInstance: sData {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: sData? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = sData()
        }
        return Static.instance!
    }
    
    class var sharedStructInstance: sData {
        struct Static {
            static let instance = sData()
        }
        return Static.instance
    }
}
