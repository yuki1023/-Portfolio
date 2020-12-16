//
//  DiaryViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD
import Kingfisher

class DiaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var postId: String!

    var comments = [Diary]()

    @IBOutlet var commentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        commentTableView.dataSource = self

        commentTableView.tableFooterView = UIView()
        
        commentTableView.rowHeight = UITableView.automaticDimension
        
        let ud = UserDefaults.standard
        postId = ud.string(forKey: "selectedId")
        
        let nib = UINib(nibName: "DiaryTableViewCell", bundle: Bundle.main)
               commentTableView.register(nib, forCellReuseIdentifier: "Cell")
               
               commentTableView.tableFooterView = UIView()
               
               commentTableView.rowHeight = 100

        loadComments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DiaryTableViewCell
//        let commentLabel = cell.viewWithTag(1) as! UILabel
        // let createDateLabel = cell.viewWithTag(4) as! UILabel

     
        cell.tweetTextView.text = comments[indexPath.row].text
        cell.userNameLabel.text = comments[indexPath.row].user.userName

        return cell
    }

    func loadComments() {
        comments = [Diary]()
        let query = NCMBQuery(className: "Comment")
        query?.whereKey("postId", equalTo: postId)
        query?.includeKey("user")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                for commentObject in result as! [NCMBObject] {
                   
                    // コメントの文字を取得
                    let text = commentObject.object(forKey: "text") as! String

                    let user = commentObject.object(forKey: "user") as! NCMBUser
                    let userModel = User(objectId: user.objectId, userName: user.userName)
//                    // Commentクラスに格納
                    let comment = Diary(postId: self.postId, user: userModel, text: text, createDate: commentObject.createDate)
                    self.comments.append(comment)

                    // テーブルをリロード
                    self.commentTableView.reloadData()
                }

            }
        })
    }

    @IBAction func addComment() {
        let alert = UIAlertController(title: "レビュー", message: "レビューを入力して下さい", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            SVProgressHUD.show()
            let object = NCMBObject(className: "Comment")
            object?.setObject(self.postId, forKey: "postId")
            object?.setObject(NCMBUser.current(), forKey: "user")
            object?.setObject(alert.textFields?.first?.text, forKey: "text")
            object?.saveInBackground({ (error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    SVProgressHUD.dismiss()
                    self.loadComments()
                }
            })
        }

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { (textField) in
            textField.placeholder = "ここにコメントを入力"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}
