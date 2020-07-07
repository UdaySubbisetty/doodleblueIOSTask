//
//  ViewController.swift
//  doodleblueIosTask
//
//  Created by uday on 7/7/20.
//  Copyright © 2020 com.Zibew. All rights reserved.
//

import Foundation

class AppViewModel
{
    var twoDimensionalArray = [
     ExpandableNames(isExpanded: true,  names: [Names(isSelected:false,name:"iosSoftware"),Names(isSelected:false,name:"Pokémon"),Names(isSelected:false,name:"Brawl Stars")]),
     ExpandableNames(isExpanded: true,  names: [Names(isSelected:false,name:"Tinder Inc"),Names(isSelected:false,name:"Tinder"),Names(isSelected:false,name:"iosSoftware"),Names(isSelected:false,name:"Explicit"),Names(isSelected:false,name:"Mojang"),Names(isSelected:false,name:"Minecraft")]),
     ExpandableNames(isExpanded: true,  names: [Names(isSelected:false,name:"Mojang"),Names(isSelected:false,name:"Calm"),Names(isSelected:false,name:"Warner"),Names(isSelected:false,name:"Heads Ups"),Names(isSelected:false,name:"Episode"),Names(isSelected:false,name:"Interactive")]),
    ]
    
    
    var isSingleSelection = true
    
    var hideOnTap = false
    
    
    func resetSelection()
    {
        for (mainIndex,mainData) in self.twoDimensionalArray.enumerated() {
            for (innderIndex,_) in mainData.names.enumerated()
            {
                self.twoDimensionalArray[mainIndex].names[innderIndex].isSelected = false
            }
        }
    }
    
    func closeHeader(section : Int)
    {
        self.twoDimensionalArray[section].isExpanded = !self.twoDimensionalArray[section].isExpanded
    }

    
    
}
