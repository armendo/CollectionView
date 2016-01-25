//
//  ViewController.swift
//  CollectionViewTutorial http://guides.codepath.com/ios/Collection-View-Guide#customizing-the-cells-and-spacing-uicollectionviewdelegateflowlayout
//
//  Created by Fer on 1/25/16.
//  Copyright © 2016 Fernando Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    let totalColors: Int = 500

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource   =   self
        collectionView.delegate     =   self
        
        
        //Programatically Configurying the flow layout
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper Methods
    func colorForIndexPath(indexPath: NSIndexPath) -> UIColor {
        if indexPath.row >= totalColors {
            return UIColor.blackColor()	// return black if we get an unexpected row index
        }
        
        var hueValue: CGFloat = CGFloat(indexPath.row) / CGFloat(totalColors)
        return UIColor(hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }

    //MARK: - UICollectionViewDataSource protocol methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return totalColors
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell{
            
        let cell    =   collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath) as! ColorCell
        
        let cellColor = colorForIndexPath(indexPath)
        cell.backgroundColor = cellColor
            
        if CGColorGetNumberOfComponents(cellColor.CGColor) == 4 {
            let redComponent = CGColorGetComponents(cellColor.CGColor)[0] * 255
            let greenComponent = CGColorGetComponents(cellColor.CGColor)[1] * 255
            let blueComponent = CGColorGetComponents(cellColor.CGColor)[2] * 255
            cell.colorLabel.text = String(format: "%.0f, %.0f, %.0f", redComponent, greenComponent, blueComponent)
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 3
        let oddEven = indexPath.row / numberOfCellsPerRow % 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        if (oddEven == 0) {
            return CGSizeMake(dimensions, dimensions)
        } else {
            return CGSizeMake(dimensions, dimensions / 2)
        }
    }


}

