//
//  RealmExtension.swift
//  Experfi
//
//  Created by Canh Tran on 4/20/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}
