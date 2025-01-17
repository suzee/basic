//
//  SpecialCollectionViewLayout.swift
//  Originality
//
//  Created by fanzz on 16/3/31.
//  Copyright © 2016年 suze. All rights reserved.
//

import UIKit

class SpecialCollectionViewLayout: UICollectionViewLayout {        
        //setting for inserts设置collectionview的cell边距
        var left:CGFloat = 10.0
        var right:CGFloat = 5.0
        var top:CGFloat = 10.0
        var bottom:CGFloat = 0
        var countInLine = 2
        /*
         // Only override drawRect: if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func drawRect(rect: CGRect) {
         // Drawing code
         }
         */
        override func collectionViewContentSize() -> CGSize {
            var height = ((self.collectionView!.bounds.width) / CGFloat(countInLine) ) * 1.25 * CGFloat(self.collectionView!.numberOfItemsInSection(0) / countInLine) + 60
            let result = self.collectionView!.numberOfItemsInSection(0) % (countInLine)
            //            let resultA = self.collectionView!.numberOfItemsInSection(0) / (countInLine)
            
            if result == 1{
                height = height+(self.collectionView!.bounds.width) / CGFloat(countInLine) * 1.25
            }
            
            
            return CGSize(width: (collectionView?.frame.width)!, height: height)
        }
        override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            var attributesArray = [UICollectionViewLayoutAttributes]()
            
            let cellCount = self.collectionView!.numberOfItemsInSection(0)
            print("cellcount:\(cellCount)")
            for i in 0 ..< cellCount {
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let attributes = self.layoutAttributesForItemAtIndexPath(indexPath)
                attributesArray.append(attributes!)
            }
            let index = self.collectionView!.indexOfAccessibilityElement(UICollectionElementKindSectionFooter)
            
            let  attr:UICollectionViewLayoutAttributes = self.collectionView!.layoutAttributesForSupplementaryElementOfKind(UICollectionElementKindSectionFooter, atIndexPath: NSIndexPath(forItem: index, inSection: 0))!
            attributesArray.append(attr)
            
            
            let index2 = self.collectionView!.indexOfAccessibilityElement(UICollectionElementKindSectionHeader)
            
            let  attr2:UICollectionViewLayoutAttributes = self.collectionView!.layoutAttributesForSupplementaryElementOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forItem: index2, inSection: 0))!
            attributesArray.append(attr2)
            
            return attributesArray
            
        }
        override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
            //        let cellCountInline = self.collectionView!.numberOfItemsInSection(0) / 2
            
            let cellCountInline = countInLine
            
            let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            
            
            
            let largeCellSide:CGFloat = self.collectionView!.bounds.width / CGFloat(countInLine) - left - right
            
            let smallCellSide:CGFloat = (self.collectionView!.bounds.width / CGFloat(countInLine) ) * 1.25
            
            //当前行数
            let lines = indexPath.item / countInLine
            
            //当前行y坐标
            let lineOriginY = (smallCellSide) * CGFloat(lines) + top
            
            //右侧单元格X坐标
            var rightLargeX =  CGFloat(10)
            if indexPath.item % countInLine == 1 {
                rightLargeX =  largeCellSide + left + right * 2
                
            }
            
            
            if indexPath.item < self.collectionView!.numberOfItemsInSection(0) {
                attribute.frame = CGRect(x: rightLargeX, y: lineOriginY  , width: largeCellSide,height: smallCellSide - top - bottom)
                
                
            }
            return attribute
            
        }
        
        override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
            
            let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
            if elementKind == UICollectionElementKindSectionHeader {
                attribute.frame = CGRect(x: 0,y: 0 ,width: self.collectionView!.frame.width,height: 0)
                
            }else {
                var height = ((self.collectionView!.bounds.width) / CGFloat(countInLine) ) * 1.25 * CGFloat(self.collectionView!.numberOfItemsInSection(0) / countInLine)
                let result = self.collectionView!.numberOfItemsInSection(0) % (countInLine)
                //            let resultA = self.collectionView!.numberOfItemsInSection(0) / (countInLine)
                
                if result == 1{
                    height = height+(self.collectionView!.bounds.width) / CGFloat(countInLine) * 1.25
                    attribute.frame = CGRect(x: 0,y: height + 10,width: screenWidth ,height: 50)
                }else {
                    attribute.frame = CGRect(x: 0,y: height + 10,width: screenWidth ,height: 50)
                }
                
            }
            return attribute
            
        }
        
        
}