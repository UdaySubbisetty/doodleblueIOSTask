//
//  ViewController.swift
//  doodleblueIosTask
//
//  Created by uday on 7/7/20.
//  Copyright © 2020 com.Zibew. All rights reserved.
//

import UIKit
class ViewController: UIViewController{
    
    @IBOutlet var tapSwitch: UISwitch!
    @IBOutlet var collectionView: UICollectionView!
    let reuseIdentifier = "cell"
    
    
    var viewModel = AppViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: !viewModel.isSingleSelection ? "Single Selection" : "Multiple Selection", style: .plain, target: self, action: #selector(handleSelectionTye))
        navigationItem.title = viewModel.isSingleSelection ? "Single Selection" : "Multiple Selection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @objc func handleSelectionTye()
    {
       
        viewModel.resetSelection()
        viewModel.isSingleSelection = !viewModel.isSingleSelection
        
        navigationItem.rightBarButtonItem?.title = !viewModel.isSingleSelection ? "Single Selection" : "Multiple Selection"
        
        navigationItem.title = viewModel.isSingleSelection ? "Single Selection" : "Multiple Selection"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.reloadData()
    }
    
    @IBAction func OpenBtnAction(_ sender: UIButton)
    {
        
        viewModel.closeHeader(section: sender.tag)
        collectionView.reloadSections([sender.tag])
        
    }
    @IBAction func tapAction(_ mySwitch: UISwitch)
       {
           viewModel.hideOnTap = mySwitch.isOn ? true : false
       }
    
    
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.twoDimensionalArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !viewModel.twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return viewModel.twoDimensionalArray[section].names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        let data : Names = viewModel.twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.titleLbl.text = data.name
        cell.backgroundColor = UIColor.cyan
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = data.isSelected ? 1 : 0
        cell.layer.borderColor = UIColor.red.cgColor
        cell.imgView.image = indexPath.row % 2 == 0 ? #imageLiteral(resourceName: "testOne") : #imageLiteral(resourceName: "testTwo")
        
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.view.frame.size.width/3)-16, height: (self.view.frame.size.width/3)-16)

    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionHeader
            
            headerView.titleLbl.text = "Section\(indexPath.section+1)"
            headerView.backgroundColor = UIColor.lightGray
            headerView.openBtn.tag = indexPath.section
            headerView.openBtn.setTitle(viewModel.twoDimensionalArray[indexPath.section].isExpanded ? "Close" : "Open", for: .normal)
            return headerView

        

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(viewModel.isSingleSelection)
        {
            
            viewModel.resetSelection()
        }
        viewModel.twoDimensionalArray[indexPath.section].names[indexPath.row].isSelected = !viewModel.twoDimensionalArray[indexPath.section].names[indexPath.row].isSelected
        
        if(viewModel.hideOnTap && viewModel.isSingleSelection)
        {
            viewModel.closeHeader(section: indexPath.section)
             collectionView.reloadSections([indexPath.section])
        }
        
        collectionView.reloadData()
        
    }
    
    
    
}

