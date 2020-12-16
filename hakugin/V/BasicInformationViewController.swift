//
//  BasicInformationViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import NYXImagesKit
import KRProgressHUD


class BasicInformationViewController: UIViewController {
    
    @IBOutlet var snowImageView : UIImageView!
    @IBOutlet var snowNameLabel : UILabel!
    @IBOutlet var snowExplainTextView : UITextView!
    @IBOutlet var adressLabel : UILabel!
    @IBOutlet var mountainLabel : UILabel!
    
    
//    var info = [Info]()
    
    var selectedMountain : String!
    
    var selectedLatitude : Double!
    var selectedLongitude : Double!
    //次のVCに渡す変数に初期値を入れておきます。
    var cityData = [String]()

    //modelのデータを持ってきます。
    let cityList = CityList()
    
    var weatherCity : String!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        selectedMountain = ud.string(forKey: "selectedM")
        selectedLatitude = ud.double(forKey: "latitude")
        selectedLongitude = ud.double(forKey: "longitude")
        
        
        // 表示したい画像の名前(拡張子含む)を引数とする。


        
        print(selectedMountain)
        
        print(cityList)
        
        loadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toWeather" {
                let weatherVC = segue.destination as! WeatherViewController
                weatherVC.selectedCity = self.weatherCity
                weatherVC.latitude = self.selectedLatitude
                weatherVC.longitude = self.selectedLongitude
            }
    
        }
        
    
    
    
    func loadData(){
        KRProgressHUD.show()
        let query = NCMBQuery(className: "info")
        query?.whereKey("snowName", equalTo: selectedMountain)
        
        query?.findObjectsInBackground({ (result, error) in
            print(result)
            if error != nil {
                
            }else{
                print(result)

                
                let infos = result as! [NCMBObject]
                
                for infoObject in infos{
                    
                    self.snowNameLabel.text = infoObject.object(forKey:"snowName") as! String
                    self.snowExplainTextView.text  = infoObject.object(forKey: "snowExplain") as! String
                    self.adressLabel.text = infoObject.object(forKey: "adress") as! String

                    let imageUrl = infoObject.object(forKey: "imageUrl") as! String
                     self.snowImageView.kf.setImage(with: URL(string: imageUrl))
                    print(self.weatherCity)
                    
                    
                }
                
                let ud = UserDefaults.standard
                ud.removeObject(forKey: "selectedM")
                
                KRProgressHUD.dismiss()
            }
            
            
        })
        
        
        
    }
    
    
    
    
    @IBAction func weatherButton(){
        self.performSegue(withIdentifier: "toWeather", sender: nil)
        
    }
    
    
}


