//
//  SearchWeatherViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/29.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit

//pickerを使うので、DelegateとDataSourceを追加します。
class SearchWeatherViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var resultButton: UIButton!

    //次のVCに渡す変数に初期値を入れておきます。
    var cityData  : [String] = ["札幌"]

    //modelのデータを持ってきます。
    let cityList = CityList()

    override func viewDidLoad() {
        super.viewDidLoad()

        //pickerを使うので、デリゲートを設定します。
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    //pickerの列の数を決めます。
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

    //pickerの行数を決めます。
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.list.count
    }

    //pickerに表示するデータを決めます。
    //ここでは取得したmodelのデータのnameを表示します。
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList.list[row].name
    }

    //選択時の挙動を決めます。
    //次の画面に渡すために、取得したmodelのデータから、codeとnameを変数に入れます。
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityData = [cityList.list[row].name]
    }

    //ボタン押した時の処理を書きます。画面遷移です。
    @IBAction func resultButton(_ sender: Any) {
        performSegue(withIdentifier: "toWeather", sender: nil)
    }

    //次の画面にデータを渡す処理を書きます。
    //prepareは、segueが動作するとViewControllerに通知してくれます。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeather" {
            //resultViewController(次の画面)で作った変数に、pickerで選択した地域の情報を入れます。
            let resultVC = segue.destination as! WeatherViewController
            resultVC.cityData = cityData
        }
    }
}
