//
//  ChannelCellTableViewCell.swift
//  Smack
//
//  Created by Mac on 10/3/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }

    }
    func configurCell(channel:Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        for id in MessageService.instance.unreadChannels{
        if id == channel.id {
            channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        
        }
    
    }
    
    
}
