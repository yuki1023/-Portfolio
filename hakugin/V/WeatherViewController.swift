//
//  WeatherViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/24.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tenkiImageView: UIImageView!
    @IBOutlet var max: UILabel!
    @IBOutlet var min: UILabel!
    @IBOutlet var taikan: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var backImageView : UIImageView!
    
    
    var descriptionWeather: String?
    var cityData : [String] = []
    var selectedCity : String!
    var longitude : Double!
    var latitude : Double!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // 表示したい画像の名前(拡張子含む)を引数とする。
        self.view.addBackground(name: "snow-mountain.jpg")
        
      // 角丸にする
      backImageView.layer.cornerRadius = backImageView.frame.size.width * 0.1
      backImageView.clipsToBounds = true
        tenkiImageView.layer.cornerRadius = tenkiImageView.frame.size.width * 0.1
        tenkiImageView.clipsToBounds = true
        
        yoho()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
    }
    
    //
    func yoho() {
        let latitude = String(self.latitude)
        let longitude = String(self.longitude)
        let text = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=55b317379a06a94f5198e9c297ff0b0e"
        print(text)
        
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                //デコード
                let json = JSON(response.data as Any)
                print(json)
                //swiftyjson
                self.descriptionWeather = json["weather"][0]["main"].string!
                print(self.descriptionWeather)
                if self.descriptionWeather == "Clouds" {
                    print("曇り")
                    self.tenkiImageView.image = UIImage(named: "kumori")
                }else if self.descriptionWeather == "Rain" {
                    print("雨")
                    self.tenkiImageView.image = UIImage(named: "ame")
                }else if self.descriptionWeather == "Snow"{
                    
                    self.tenkiImageView.image = UIImage(named: "yuki.gif")
                    
                }else {
                    print("晴れ")
                    self.tenkiImageView.image = UIImage(named: "hare")
                }
                
                print(json["main"]["temp_max"].number?.stringValue)
                
                self.max.text = "\(Int(json["main"]["temp_max"].number!).description)℃"
                self.min.text = "\(Int(json["main"]["temp_min"].number!).description)℃"
                self.taikan.text = "\(Int(json["main"]["temp"].number!).description)℃"
                
                self.wind.text = "\(Int(json["wind"]["speed"].number!).description)m/s"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension UIView {
    func addBackground(name: String) {
        // スクリーンサイズの取得
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        // スクリーンサイズにあわせてimageViewの配置
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //imageViewに背景画像を表示
        imageViewBackground.image = UIImage(named: name)
        
        // 画像の表示モードを変更。
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        // subviewをメインビューに追加
        self.addSubview(imageViewBackground)
        // 加えたsubviewを、最背面に設置する
        self.sendSubviewToBack(imageViewBackground)
    }
}
