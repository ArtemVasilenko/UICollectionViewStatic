
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    var cellIds = ["Purple Cell", "Green Cell", "Blue Cell", "Red Cell"]
    var cellSizes = Array(repeating: CGSize(width: 170, height: 80), count: 4)
    
    var tapGesture = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(gest))
            
        myCollection.addGestureRecognizer(tapGesture)
    }
    
    @objc func gest(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began: guard let selectedIndexPath = collectionFromStoryboard.indexPathForItem(at: sender.location(in: collectionFromStoryboard)) else { break }
        collectionFromStoryboard.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionFromStoryboard.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            collectionFromStoryboard.endInteractiveMovement()
        default:
            collectionFromStoryboard.cancelInteractiveMovement()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellIds[indexPath.row], for: indexPath)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSizes[indexPath.row]
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        if indexPath.row % 2 == 0 {
        //            cellSizes = [CGSize(width: 210, height: 60),
        //                         CGSize(width: 180, height: 100),
        //                         CGSize(width: 170, height: 80),
        //                         CGSize(width: 150, height: 150)]
        //        } else {
        //            cellSizes = [CGSize(width: Int.random(in: 5...20) * 10,
        //                                height: Int.random(in: 5...20) * 10),
        //                         CGSize(width: Int.random(in: 5...20) * 10,
        //                                height: Int.random(in: 5...20) * 10),
        //                         CGSize(width: Int.random(in: 5...20) * 10,
        //                                height: Int.random(in: 5...20) * 10),
        //                         CGSize(width: Int.random(in: 5...20) * 10,
        //                                height: Int.random(in: 5...20) * 10)]
        //        }
        
        switch indexPath.row {
        case 0:
            cellSizes[0] = CGSize(width: Int.random(in: 5...20) * 10,
                                  height: Int.random(in: 5...20) * 10)
        case 1:
            cellSizes[1] = CGSize(width: Int.random(in: 5...20) * 10,
                                  height: Int.random(in: 5...20) * 10)
            
        case 2:
            cellSizes[2] = CGSize(width: Int.random(in: 5...20) * 10,
                                  height: Int.random(in: 5...20) * 10)
        case 3:
            cellSizes[3] = CGSize(width: Int.random(in: 5...20) * 10,
                                  height: Int.random(in: 5...20) * 10)
            default: ()
        }
        
        
        collectionView.reloadItems(at: [indexPath])
        print("We pressed \(cellIds[indexPath.row])")
        
    }
    
}

extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        print(sourceIndexPath.item, destinationIndexPath.item)

        let temp = cellIds.remove(at: sourceIndexPath.item)
        cellIds.insert(temp, at: destinationIndexPath.item)
    }
}
