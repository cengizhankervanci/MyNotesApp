//
//  ViewController.swift
//  NotePro
//
//  Created by Cengizhan Kervancı on 9.06.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var noteVM : NoteViewModel!
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarView()
        createTableView()
        
        self.noteVM = NoteViewModel(noteModel: NoteModel())
    }
    
    func createNavBarView(){
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.tintColor = .systemBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemBackground]
        
        let rightButton = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(addNotes))
        navigationItem.rightBarButtonItem = rightButton
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    func createTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteVM == nil ? 0 : self.noteVM.noteCounter()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = noteVM.matchDatas(index: indexPath.row).title
        content.secondaryText = noteVM.matchDatas(index: indexPath.row).content
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.editAlert(title: self.noteVM.matchDatas(index: indexPath.row).title, content: self.noteVM.matchDatas(index: indexPath.row).content, index: indexPath.row)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            self.noteVM.deleteNote(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return configuration
    }
    
    @objc func addNotes(){
        makeAlert()
    }
    
    func makeAlert(){
        let alert = UIAlertController(title: "Add Notes", message: "Please enter your notes...", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "Please Enter Title"
        }
        alert.addTextField { content in
            content.placeholder = "Please Enter Content"
        }
        
        let okeyButton = UIAlertAction(title: "Enter", style: .default) { action in
            guard let textField = alert.textFields?[0], let inputText = textField.text , !inputText.isEmpty , let detail = alert.textFields?[1], let detailText = detail.text, !detailText.isEmpty else{
                return
            }
            self.noteVM.addNotes(title: String(inputText), content: String(detailText))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alert.addAction(okeyButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func editAlert(title : String , content : String , index : Int){
        let editAlert = UIAlertController(title: "Edit", message: "Edit your notes...", preferredStyle: .alert)
        editAlert.addTextField { edit in
            edit.text = title
        }
        editAlert.addTextField { editContent in
            editContent.text = content
        }
        
        let editButton = UIAlertAction(title: "Edit", style: .default) { editAction in
            guard let editTextField = editAlert.textFields?[0], let editText = editTextField.text , let editContentTextField = editAlert.textFields?[1], let editContentText = editContentTextField.text else{
                return
            }
            self.noteVM.updateNotes(title: editText, content: editContentText, index: index)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        editAlert.addAction(editButton)
        self.present(editAlert, animated: true, completion: nil)
    }

}

