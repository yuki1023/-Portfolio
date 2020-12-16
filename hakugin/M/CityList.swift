//
//  CityList.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/24.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import Foundation

class CityList {

    var list = [CityModel]()

    //Webサイトを見て適当に地域を追加します。
    init() {
        list.append(CityModel(cityName: "札幌"))
        list.append(CityModel(cityName: "室蘭"))
        list.append(CityModel(cityName: "chiba"))
        list.append(CityModel(cityName: "a"))
        list.append(CityModel(cityName: "東京"))
        list.append(CityModel(cityName: "横浜"))
    }
}
