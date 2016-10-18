//
//  CustomCollectionFlowLayout.swift
//  Experfi
//
//  Created by Canh Tran on 3/18/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit

class CustomCollectionFlowLayout: UICollectionViewFlowLayout {
    var currentCellPath: NSIndexPath?
    var currentCellCenter: CGPoint?
    var currentCellScale: CGFloat?
    
    
    func setCurrentCellScale(scale: CGFloat)
    {
        currentCellScale = scale
        self.invalidateLayout()
    }
    
    func setCurrentCellCenter(origin: CGPoint)
    {
        currentCellCenter = origin
        self.invalidateLayout()
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath:
        NSIndexPath) -> UICollectionViewLayoutAttributes {
            
            let attributes =
            super.layoutAttributesForItemAtIndexPath(indexPath)
            
            self.modifyLayoutAttributes(attributes!)
            return attributes!
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributesInRect =
        super.layoutAttributesForElementsInRect(rect)
        
        for cellAttributes in allAttributesInRect! {
            self.modifyLayoutAttributes(cellAttributes )
        }
        return allAttributesInRect!
    }
    func modifyLayoutAttributes(layoutattributes:
        UICollectionViewLayoutAttributes) {
            
            if layoutattributes.indexPath == currentCellPath
            {
                layoutattributes.transform3D =
                    CATransform3DMakeScale(currentCellScale!,
                        currentCellScale!, 1.0)
                layoutattributes.center = currentCellCenter!
                layoutattributes.zIndex = 1
            }
    }
}
