//
//  PokemonTableViewCell.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-12.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View properies
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    // View's view model
    var viewModel: PokemonTableViewCellViewModel? {
        didSet {
            //bind to viewmodel?
            titleLabel.text = viewModel?.name
            //set image?
            
            return
        }
    }
    
    func setupViews(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        //add image?
    }
}
