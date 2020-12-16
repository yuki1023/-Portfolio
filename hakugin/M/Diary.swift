//
//  Diary.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/12/01.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit

class Diary {
    var postId: String
    var user: User
    var text: String
    var createDate: Date
    

    init(postId: String, user: User, text: String, createDate: Date) {
        self.postId = postId
        self.user = user
        self.text = text
        self.createDate = createDate
    }
}
