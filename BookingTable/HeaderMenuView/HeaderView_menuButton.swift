//
//  HeaderView_menuButton.swift
//  BookingTable
//
//  Created by Sergey Fedotov on 14.10.2020.
//

import UIKit

extension HeaderView {
    internal func menuButton() {
        let button = UIButton()
        //button.setTitle("Menu", for: .normal)
        
        let icon = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(#colorLiteral(red: 0.6633401113, green: 0.5, blue: 0, alpha: 1), renderingMode: .alwaysOriginal).scaleX(1.75)
        
        button.setImage(icon, for: .normal)
                
        button.layer.bounds.size = CGSize(
            width: self.bounds.height/2,
            height: self.bounds.height/2)
                
        button.center = CGPoint(
            x: self.bounds.width/10,
            y: self.bounds.height - (button.frame.height * 0.75))
        
        self.addSubview(button)
    }
}
