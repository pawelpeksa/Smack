//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    // Outlets
    
    @IBOutlet weak var userImg: CircleImgView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    @IBOutlet weak var adminPanel: RoundedButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        adminPanel.isHidden = true
    
        
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNALS_LOADED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userLogout(_:)), name: NOTIF_USER_LOGOUT, object: nil)
        
        SocketService.instance.startListeningOnGetChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.startListeningOnGetChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
         NotificationCenter.default.addObserver(self, selector: #selector(userLogout(_:)), name: NOTIF_USER_LOGOUT, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if adminsArray.contains(LocalUserDataService.instance.id) {
          adminPanel.isHidden = false
        }
        
        
    }
    
    
    @IBAction func adminPannelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_ADMIN_PANEL, sender: nil)
    }
    
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let addChanel = AddChannelVC()
            addChanel.modalPresentationStyle = .custom
            present(addChanel, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            //show profile page
            let profile = ProfileVCViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
     @objc func userLogout(_ notif:Notification){
        adminPanel.isHidden = true
        tableView.reloadData()
    }
    
    @objc func userDataDidChange(_ notif:Notification){
        setupUserInfo()
        
    }
    
    @objc func channelsLoaded(_ notif:Notification){
        tableView.reloadData()
    }
    
    
    
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(LocalUserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: LocalUserDataService.instance.avatarName)
            userImg.backgroundColor = LocalUserDataService.instance.returnUIColor(components: LocalUserDataService.instance.avatarColor)
            
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named:"menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configurCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0{
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
            let index = IndexPath(row: indexPath.row, section: 0)
            tableView.reloadRows(at: [index], with: .none)
            tableView.selectRow(at: index, animated: false, scrollPosition: .none)
            
            
        }
        
        NotificationCenter.default.post(name: NOTIF_CHANNAL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
        
        
    }
}
