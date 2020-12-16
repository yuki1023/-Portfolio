//
//  ViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
// 2つimportする
import MapKit
import CoreLocation
import NCMB

// CLLocationManagerDelegateを継承する
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    // storyboardから接続する
    @IBOutlet weak var mapView: MKMapView!
    // locationManagerを宣言する
    var locationManager: CLLocationManager!
    
    
    
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    
    var detailId = [String]()
    var detailsub = [String]()
    var detailImage = [String]()
    var detailtext = [String]()
    var likes = [Bool]()
    var userImages = [String]()
    var userNames = [String]()
    var url = [String]()
    
    var nextId : String?
    var nextText : String?
    var nextTitle: String?
    var nextImage: String?
    var nextUrl : String?
    var nextLatitude : Double?
    var nextLongitude : Double?
    
    
    var latitude : Double!
    var longitude : Double!
    var latitudes = [Double]()
    var longitudes = [Double]()
    
    var logoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ロケーションマネージャーのセットアップ
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        
        
        
        // 位置情報の使用の許可を得る
        locationManager.requestWhenInUseAuthorization()
        self.requestCurrentLocation()
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.delegate = self
        
        self.view.backgroundColor = UIColor.white
        //imageView作成
        self.logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 204, height: 77))
        //画面centerに
        self.logoImageView.center = self.view.center
        //logo設定
        self.logoImageView.image = UIImage(named: "ItunesArtwork.jpg")
        //viewに追加
        self.view.addSubview(self.logoImageView)
        
        self.logoImageView.removeFromSuperview()
        
        loadPin()
        
        
    }
    
    
   
    
    
    func presentInfoVC() {
       
        
        let ud = UserDefaults.standard
        ud.set(self.nextText, forKey: "selectedM")
        ud.set(self.nextLatitude, forKey: "latitude")
        ud.set(self.nextLongitude, forKey: "longitude")
        ud.set(self.nextId, forKey: "selectedId")
        ud.set(self.nextUrl, forKey: "selectedUrl")
        ud.synchronize()
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = false
            pinView?.pinTintColor = UIColor.purple
            pinView?.canShowCallout = true
            let rightButton: AnyObject! = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //処理
    }
    
    
    func requestCurrentLocation(){
        self.locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
        
        
        if self.detailId.count != 0{
            for i in 0...self.detailId.count{
                if i == self.detailId.count {
                    break
                }else {
                    if (view.annotation!.title!)! == self.detailtext[i]{
                        
                        
                        
                        self.nextId = self.detailId[i]
                        self.nextText = self.detailtext[i]
                        self.nextTitle = self.detailsub[i]
                        self.nextUrl = self.url[i]
                        self.nextLatitude = self.latitudes[i]
                        self.nextLongitude = self.longitudes[i]
                        
                    }else{
                        
                    }
                }
            }
        }
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer){
        let view = gestureRecognizer.view
        let tapPoint = gestureRecognizer.location(in: view)
        //ピン部分のタップだったらリターン
        if tapPoint.x >= 0 && tapPoint.y >= 0 {
            return
        }
        
        presentInfoVC()
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
        
    }
    
    
    // 許可を求めるためのdelegateメソッド
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        // 許可されてない場合
        case .notDetermined:
            //許可を求める
            manager.requestWhenInUseAuthorization()
        // 拒否されてる場合
        case .restricted, .denied:
            // 何もしない
            break
        // 許可されている場合
        case .authorizedAlways, .authorizedWhenInUse:
            // 現在地の取得を開始
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    
    //NCMBから読み込み
    func loadPin() {
        let query = NCMBQuery(className: "map")
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                
            }else {
                self.detailId = []
                
                let objects = result as! [NCMBObject]
                for object in objects{
                    
                    let latitude = object.object(forKey: "latitude") as! Double
                    let longitude = object.object(forKey: "longitude") as! Double
                    
                    // 投稿の情報を取得
                    let text = object.object(forKey: "text") as! String
                    let sub  = object.object(forKey: "subtext") as! String
                    let url = object.object(forKey: "url") as! String
                    
                    
                    self.detailId.append(object.objectId)
                    self.detailtext.append(text)
                    self.detailsub.append(sub)
                    self.latitudes.append(latitude)
                    self.longitudes.append(longitude)
                    self.url.append(url)
                    
                }
                
                
                //複数ピンをfor文を回して立てる
                for i in 0...self.detailId.count{
                    
                    if i == self.detailId.count {
                        break
                    }else {
                        var pin : MKPointAnnotation = MKPointAnnotation()
                        pin.title = self.detailtext[i]
                        pin.subtitle = self.detailsub[i]
                        let x = self.latitudes[i]
                        let y = self.longitudes[i]
                        pin.coordinate = CLLocationCoordinate2DMake(x, y)
                        self.mapView.addAnnotation(pin)
                        continue
                    }
                    
                }
                
            }
            }
        )}
    
    
}

