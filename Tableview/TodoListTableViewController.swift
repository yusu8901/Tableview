//
//  TodoListTableViewController.swift
//  Tableview
//
//  Created by 所紀彦 on 2020/07/25.
//  Copyright © 2020 所紀彦. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController,UITextFieldDelegate {
    
    let saveData: UserDefaults = UserDefaults.standard
    
    
    
    // アイテムの型
    class Item {
        var title : String
        var done: Bool = false
        
        init(title: String) {
            self.title = title
        }
    }
    
    // この配列に作ったアイテムを追加していく
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // NaviBarのタイトルを大きく表示させる
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        // あらかじめ3つアイテムを作っておく
       // let item1: Item = Item(title: "　")
        //            let item2: Item = Item(title: "牛乳を買う")
        //            let item3: Item = Item(title: "手紙を書く")
        
        // 配列に追加
       // itemArray.append(item1)
        //            itemArray.append(item2)
        //            itemArray.append(item3)
        
        
        
        
        
    }
    
    
    
    // MARK - セルの数を指定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    
    // MARK - セルのカスタマイズ
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
        
    }
    
    
    // MARK - チェックマーク機能
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルに実行される処理
        
        let item = itemArray[indexPath.row]
        
        // チェックマーク
        item.done = !item.done
        
        
        
        // リロードしてUIに反映
        self.tableView.reloadData()
        
        // セルを選択した時の背景の変化を遅くする
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {// returnキーを押した時の処理
        if title != nil {
            itemArray = saveData.object(forKey: "content") as? String
        }
    
        saveData.set(itemArray , forKey: "content")
        
        self.tableView.reloadData() //データをリロードする
        return true
    
    }
    
    // MARK - 新規アイテム追加機能
    @IBAction func addButtonPressed(_ sender: Any) {
        // プラスボタンが押された時に実行される処理
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "新しいアイテムを追加", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "リストに追加", style: .default) { (action) in
            // 「リストに追加」を押された時に実行される処理
            
            let newItem: Item = Item(title: textField.text!)
            
            
            // アイテム追加処理
            self.itemArray.append(newItem)
            self.tableView.reloadData()
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいアイテム"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
//        saveData.set(itemArray , forKey: "content")
        
        
        
        
    }
    
    // MARK - スワイプでのアイテム削除機能
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // アイテム削除処理
        itemArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    
    
    
    
}
