//
//  UICollectionViewController+Custom.swift
//  ShopOnline
//
//  Created by Canh on 8/23/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

public extension UICollectionView
{
    func registerCellClass(cellClass: AnyClass)
    {
        let identifier = String.className(cellClass)
        self.registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(cellClass: AnyClass)
    {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.registerNib(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewClass(viewClass: AnyClass)
    {
        let identifier = String.className(viewClass)
        self.registerClass(viewClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewNib(viewClass: AnyClass)
    {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.registerNib(nib, forCellWithReuseIdentifier: identifier)
    }
 
}