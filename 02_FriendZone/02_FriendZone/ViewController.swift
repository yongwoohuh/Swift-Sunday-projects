//
//  ViewController.swift
//  02_FriendZone
//
//  Created by Yongwoo Huh on 2020/01/18.
//  Copyright © 2020 Yongwoo Huh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - properties
    var friends = [Friend]()
    var selectedFriend: Int? = nil

    // MARK: - viewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    // MARK: - tableview methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(friend: friends[indexPath.row], position: indexPath.row)
    }
    
    // MARK: - load / save data
    func loadData() {
        let defaults = UserDefaults.standard
        
        guard let savedData = defaults.data(forKey: "Friends") else { return }
        
        let decoder = JSONDecoder()
        
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else {
            return
        }
        
        friends = savedFriends
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(friends) else {
            fatalError("Unable to encode friends data.")
        }
        
        defaults.set(savedData, forKey: "Friends")
    }
    
    //  MARK: - methods for adding and editing friend
    @objc func addFriend() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        
        configure(friend: friend, position: friends.count - 1)
    }
    
    func configure(friend: Friend, position: Int) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendViewController") as? FriendViewController else {
            fatalError("Unable to create FriendViewController")
        }
        selectedFriend = position
        vc.delegate = self
        vc.friend = friend
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func update(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }

}

