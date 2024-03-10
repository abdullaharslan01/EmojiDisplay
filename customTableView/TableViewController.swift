//
//  TableViewController.swift
//  customTableView
//
//  Created by abdullah on 10.03.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var emojis: [Emoji] = [
                Emoji(symbol: "😀", name: "Grinning Face",
                      description: "A typical smiley face.", usage: "happiness"),
                Emoji(symbol: "😕", name: "Confused Face",
                      description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
                Emoji(symbol: "😍", name: "Heart Eyes",
                      description: "A smiley face with hearts for eyes.",
                      usage: "love of something; attractive"),
                Emoji(symbol: "👮", name: "Police Officer",
                      description: "A police officer wearing a blue cap with a gold badge.",
                      usage: "person of authority"),
                Emoji(symbol: "🐢", name: "Turtle",
                      description: "A cute turtle.",
                      usage: "Something slow"),
                Emoji(symbol: "🐘", name: "Elephant",
                      description: "A gray elephant.",
                      usage: "good memory"),
                Emoji(symbol: "🍝", name: "Spaghetti",
                      description: "A plate of spaghetti.",
                      usage: "spaghetti"),
                Emoji(symbol: "🎲", name: "Die",
                      description: "A single die.",
                      usage: "taking a risk, chance; game"),
                Emoji(symbol: "⛺️", name: "Tent",
                      description: "A small tent.",
                      usage: "camping"),
                Emoji(symbol: "📚", name: "Stack of Books",
                      description: "Three colored books stacked on each other.",
                      usage: "homework, studying"),
                Emoji(symbol: "💔", name: "Broken Heart",
                      description: "A red, broken heart.",
                      usage: "extreme sadness"),
                Emoji(symbol: "💤", name: "Snore",
                      description: "Three blue \'z\'s.",
                      usage: "tired, sleepiness"),
                Emoji(symbol: "🏁", name: "Checkered Flag",
                      description: "A black-and-white checkered flag.",
                      usage: "completion")
            ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    
    @IBAction func editButtonTapped(_ button: UIBarButtonItem)
    {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    
    
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emoji = emojis[indexPath.row]
        
        // Kendi tableViewCell sınıfımızdan türetmemiz gerekiyor.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell") as! TableViewCell
        
        cell.update(with: emoji)
        
        return cell
    
        
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    
    // Bu fonksiyon NewEmojiController tarafından çalıştırılacak.
    @IBAction func unwindFromNewEmoji(_ segue: UIStoryboardSegue) {
    
        // Eğer identifier istediğimiz ise ve kullancının geldiği sayfaya erişim sağlıyoruz. Bu erişim ile istediğimiz objeye ulaşabiliriz.
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? NewEmojiTableViewController, let newEmoji = sourceViewController.emoji else {return}
        
        
        // Burada kullancı eğer tableView basarak gittiyse güncelleyecek anlamına gelir. Ona göre o satırı güncellemiş oluyoruz.
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            // TableViewdaki seçilen hücreyi yeniler.
            emojis[selectedIndexPath.row] = newEmoji
            
            // TableViewdaki belirli bir hücreyi güncelleme işlemine denir.
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
        }
        else {
            // Seçili bir hücre bulunmazsa yeni ekleme anlamına geliyor.
            
            
            // Yeni bir hücre için IndexPath oluşturur.
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
                
            // Database yeni item ekliyoruz.
            emojis.append(newEmoji)
                
            // Belirtiğimiz indexPath yeni bir row Oluşturuyoruz.
            tableView.insertRows(at: [newIndexPath], with: .automatic)
                
        }
        
    

        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEmoji = emojis[indexPath.row]
        
        performSegue(withIdentifier: "toEditEmoji", sender: nil)
    }
    
    var selectedEmoji: Emoji?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditEmoji" {
           
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedEmoji = emojis[selectedIndexPath.row]
            
            // Segue'in Storyboard'da bağlı olduğu yer bir NavigationController, bu yüzden önce oraya bağlanıyoruz.
            let navigationController = segue.destination as! UINavigationController
            
            // NavigationController'den tabViewController(kendisine bağlı olan ilk) sayfaya ulaşabiliriz.
            let destinationPage = navigationController.topViewController as! NewEmojiTableViewController
            
            destinationPage.emoji = selectedEmoji
            
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    
        if editingStyle == .delete {
            
            // DataBaseden seçilen data kaldırırız.
            emojis.remove(at: indexPath.row)
            
            // TableViewdan animasyonlu bir şekilde silme işlemi yapar.
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
        }
        
        
    }
    
}
