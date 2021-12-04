//
//  CollectionViewDatasource.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation
import UIKit

class MovieCollectionDatasource<CellType,Model>:NSObject,UICollectionViewDataSource where CellType : UICollectionViewCell{
    let cellIdentifier: String
    var items: [Model]
    let configureCell: (CellType, Model) -> ()
   
    init(cellIdentifier: String,items: [Model], configureCell: @escaping (CellType,Model) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    
    }
    func removeAll() {
        self.items.removeAll()
    }
    func updateItems( items: [Model]) {
        self.items += items
        print("Total:\(self.items.count)")
    }
    func getItem(indexPath:IndexPath) -> Model {
        return self.items[indexPath.row]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            return UICollectionViewCell()
        }
        let vm = self.items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
}
