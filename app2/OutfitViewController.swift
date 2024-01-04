//
//  OutfitViewController.swift
//  app2
//
//  Created by Cindy Liang on 6/10/23.
//

import UIKit

class OutfitViewController: UIViewController, addSongDelegate {
    func addSong(song: Clothes) {
        if (song.clothesType == "Top"){
            clothes[0].append(song)
//            collectionView.performBatchUpdates({
//                let indexPath = IndexPath(row: 0, section: clothes[0].count-1)
//                clothes[0].append(song) //add your object to data source first
//                self.collectionView?.insertItems(at: [indexPath])
//            }, completion: nil)
        }
        else if (song.clothesType == "Bottom"){
            clothes[1].append(song)
        }
        else if (song.clothesType == "Outer"){
            clothes[2].append(song)
        }
        else{
            clothes[3].append(song)
        }
        
        collectionView.reloadData()
        
    }
    
    
    
    

    var collectionView: UICollectionView!
    
    
    var sections = ["Top", "Bottom", "Outer", "Other"]
    
    var tempImage = UIImage(named: "box")
    
    var mainVC = false
    var travelVC = false
    
    var clothes: [[Clothes]] = [
        [Clothes(imageName:  UIImage(named: "top1")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "top2")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "top3")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "top4")!, clothesTypeEntered: "Top")],
        [Clothes(imageName: UIImage(named: "bottom1")!, clothesTypeEntered: "Bottom"), Clothes(imageName: UIImage(named: "bottom2")!, clothesTypeEntered: "Bottom"), Clothes(imageName: UIImage(named: "bottom3")!, clothesTypeEntered: "Bottom"), Clothes(imageName: UIImage(named: "bottom4")!, clothesTypeEntered: "Bottom")],
        [Clothes(imageName: UIImage(named: "outer1")!, clothesTypeEntered: "Outer"), Clothes(imageName: UIImage(named: "outer2")!, clothesTypeEntered: "Outer"), Clothes(imageName: UIImage(named: "outer3")!, clothesTypeEntered: "Outer"), Clothes(imageName: UIImage(named: "outer4")!, clothesTypeEntered: "Outer")],
        [Clothes(imageName: UIImage(named: "other1")!, clothesTypeEntered: "Other"), Clothes(imageName: UIImage(named: "other2")!, clothesTypeEntered: "Other"), Clothes(imageName: UIImage(named: "other3")!, clothesTypeEntered: "Other"), Clothes(imageName: UIImage(named: "other4")!, clothesTypeEntered: "Other")]
    ]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    
    weak var delegate: banana?
    weak var travelDelegate: banana?
    
    init(inputDelegate: banana) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    func setTravelDelegate(delegate : banana) {
        travelDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        title = "Closet"
        view.backgroundColor = .white

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)



        //MARK: Header Code
        collectionView.register(CustomCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseID)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Clothes", style: .plain, target: self, action: #selector(openAddSong))
       
        
        fetchClothes()
        
        setupConstraints()
    }
    
    func fetchClothes(){
        //i think i may need to redo everything to implement core data
//        do{
//            context.fetch(ClothesPers.fetchRequest())
//        }
//        catch{
//
//        }
    }
    
    //TODO: Add Reorder Function
    func addClothes(val1: Int, val2: Int) -> Clothes {
        return clothes[val1][val2]
}
    
    func setupConstraints() {
        let collectionViewPadding: CGFloat = 12

      
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
       
    
    }
    @objc func openAddSong() {
        navigationController?.pushViewController(PushViewController(inputDelegate: self), animated: true)
    }

}

extension OutfitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return clothes[section].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.collectionView) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? CustomCollectionViewCell {
                let shape = clothes[indexPath.section][indexPath.item]
                cell.update(clothes: shape)
                return cell
            }
            
        }
        

        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return clothes.count
    }

    //MARK: Header setup function
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseID, for: indexPath) as? CustomCollectionViewHeader {
                header.configure(section: sections[indexPath.section])
                return header
            }

        return UICollectionReusableView()
    }
    
}

extension OutfitViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
            return CGSize(width: len, height: len)
    
    }

    //MARK: Header shape code
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
       
    }
    
}

extension OutfitViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item = indexPath
        delegate?.addClothesItemToVC(clo: addClothes(val1: item[0], val2: item[1]), mainVCPress: mainVC, travelVCPress: travelVC)
        travelDelegate?.addClothesItemToVC(clo: addClothes(val1: item[0], val2: item[1]), mainVCPress: mainVC, travelVCPress: travelVC)
        
        print(travelVC)
        print (item)
    }
    
}
protocol banana: UIViewController {
    func addClothesItemToVC(clo: Clothes, mainVCPress: Bool, travelVCPress: Bool)
    
}

