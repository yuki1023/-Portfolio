//
//  Info.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/17.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import NCMB

class Info: NSObject {
    
    
    var snowName: String!
    var snowImage: String!
    var snowExplain: String!
    var adress: String!
    var mountain : String!
    
    
    
    
    init(snowName: String, snowImage: String, snowExplain: String, adress: String, mountain:String) {
        // 取得した値を変数に代入
        self.snowName = snowName
        self.snowImage = snowImage
        self.snowExplain = snowExplain
        self.mountain = mountain
        self.adress = adress
        
        
    }
    
    
    
    
}
