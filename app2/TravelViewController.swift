//
//  TravelViewController.swift
//  app2
//
//  Created by Cindy Liang on 6/12/23.
//

import Foundation
import UIKit
//

//in hindsight it might need to be a vertical view controller
class TravelViewController: UIViewController,  UIScrollViewDelegate,addSongDelegate, banana{
    func addClothesItemToVC(clo: Clothes, mainVCPress: Bool, travelVCPress: Bool) {
        print(travelVCPress)
        if (travelVCPress){
            clothes[0].append(clo)
            collectionView.reloadData()
            permOutfitViewController?.travelVC = false
        }
    }
    
    
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            return scroll
        }()
        
       
        
      
      
   
    
    func addSong(song: Clothes) {
        
    }
    
    weak var delegate: vacayDelegate?
    
    init(inputDelegate: vacayDelegate) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var permOutfitViewController:OutfitViewController? = nil
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let filterCellReuseID1 = "filterCellReuseID1" // i might need more for this
    let filterCellReuseID2 = "filterCellReuseID2"
    let filterCellReuseID3 = "filterCellReuseID3"
    let filterCellReuseID4 = "filterCellReuseID4"
    let filterCellReuseID5 = "filterCellReuseID5"
    let filterCellReuseID6 = "filterCellReuseID6"
    let filterCellReuseID7 = "filterCellReuseID7"
    
    var waiting = false
    
    private var filters = [Clothes(imageName:  UIImage(named: "welcome1")!, clothesTypeEntered: "Top"), Clothes(imageName:  UIImage(named: "welcome1")!, clothesTypeEntered: "Top")]
    
    
    let intro = UILabel()
    let locationLaebl = UILabel()
    let locationText = UITextField()
    let lengthLabel = UILabel()
    let lengthText = UITextField()
    let goButton = UIButton()
    
    
    let day1Label = UILabel()
    let day1Text = UILabel()
    let day1OLabel = UILabel()
    let day1OText = UILabel()
    
    
    
    let day2Label = UILabel()
    let day2Text = UILabel()
    let day2OLabel = UILabel()
    let day2OText = UILabel()
    
    let day3Label = UILabel()
    let day3Text = UILabel()
    let day3OLabel = UILabel()
    let day3OText = UILabel()
    
    let day4Label = UILabel()
    let day4Text = UILabel()
    let day4OLabel = UILabel()
    let day4OText = UILabel()
    
    let day5Label = UILabel()
    let day5Text = UILabel()
    let day5OLabel = UILabel()
    let day5OText = UILabel()
    
    let day6Label = UILabel()
    let day6Text = UILabel()
    let day6OLabel = UILabel()
    let day6OText = UILabel()
    
    let day7Label = UILabel()
    let day7Text = UILabel()
    let day7OLabel = UILabel()
    let day7OText = UILabel()
    
    let addClothes = UIButton()
//    var filterCollectionView1: UICollectionView!
//    var filterCollectionView2: UICollectionView!
//    var filterCollectionView3: UICollectionView!
//    var filterCollectionView4: UICollectionView!
//    var filterCollectionView5: UICollectionView!
//    var filterCollectionView6: UICollectionView!
//    var filterCollectionView7: UICollectionView!
    
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    
    var collectionView: UICollectionView!
    
    var sections = ["Vacation Outfit"]
    
    var dayTe: [Clothes] = [Clothes(imageName:  UIImage(named: "box")!, clothesTypeEntered: "Day 1"), Clothes(imageName: UIImage(named: "box")!, clothesTypeEntered: "Day 1"), Clothes(imageName: UIImage(named: "box")!, clothesTypeEntered: "Day 1"), Clothes(imageName: UIImage(named: "box")!, clothesTypeEntered: "Day 1")]
    
    var clothes: [[Clothes]] = [
        [Clothes(imageName:  UIImage(named: "top1")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "bottom1")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "outer1")!, clothesTypeEntered: "Top"), Clothes(imageName: UIImage(named: "other1")!, clothesTypeEntered: "Top")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        intro.translatesAutoresizingMaskIntoConstraints = false
        intro.font = UIFont(name:"Helvetica-Bold", size:32)
        intro.text = "Plan for Travel"
        intro.lineBreakMode = .byWordWrapping
        scrollView.addSubview(intro)
        
        locationLaebl.text = "Location of Travel:"
        locationLaebl.font = .systemFont(ofSize: 20, weight: .bold)
        locationLaebl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationLaebl)
        
        
        lengthLabel.text = "Length of Travel:"
        lengthLabel.font = .systemFont(ofSize: 20, weight: .bold)
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(lengthLabel)
        
        if let zip = UserDefaults().value(forKey:"zipcodeVacay") as? String{
            locationText.text = zip
            print("in here")
        }
        else{
            locationText.placeholder = "Enter zipcode"
        }
        
        //locationText.placeholder = "Enter zipcode"
        locationText.font = .systemFont(ofSize: 20, weight: .bold)
        locationText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(locationText)
        
        if let len = UserDefaults().value(forKey:"lenVacation") as? String{
            lengthText.text = len
            print("in here")
        }
        else{
            lengthText.placeholder = "Enter number of days"
        }
        //lengthText.placeholder = "Enter number of days"
        lengthText.font = .systemFont(ofSize: 20, weight: .bold)
        lengthText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(lengthText)
        
        goButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.setTitleColor(.black, for: .normal)
        goButton.setImage(UIImage(named: "go"), for: .normal)
        scrollView.addSubview(goButton)
        
        addClothes.addTarget(self, action: #selector(addClothesButt), for: .touchUpInside)
        addClothes.translatesAutoresizingMaskIntoConstraints = false
        addClothes.setTitleColor(.black, for: .normal)
        
        addClothes.setImage(UIImage(named: "Frame 1"), for: .normal)
        scrollView.addSubview(addClothes)
        
        
        day1Label.translatesAutoresizingMaskIntoConstraints = false
        day1Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day1Label)
        
        day1Text.translatesAutoresizingMaskIntoConstraints = false
        day1Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day1Text)
        
        day1OLabel.translatesAutoresizingMaskIntoConstraints = false
        day1OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day1OLabel)
        
        day1OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day1OText)
        
       
        day2Label.translatesAutoresizingMaskIntoConstraints = false
        day2Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day2Label)
        
        day2Text.translatesAutoresizingMaskIntoConstraints = false
        day2Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day2Text)
        
        day2OLabel.translatesAutoresizingMaskIntoConstraints = false
        day2OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day2OLabel)
        
        day2OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day2OText)
    
        
        
        day3Label.translatesAutoresizingMaskIntoConstraints = false
        day3Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day3Label)
        
        day3Text.translatesAutoresizingMaskIntoConstraints = false
        day3Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day3Text)
        
        day3OLabel.translatesAutoresizingMaskIntoConstraints = false
        day3OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day3OLabel)
        
        day3OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day3OText)
    
        
        day4Label.translatesAutoresizingMaskIntoConstraints = false
        day4Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day4Label)
        
        day4Text.translatesAutoresizingMaskIntoConstraints = false
        day4Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day4Text)
        
        day4OLabel.translatesAutoresizingMaskIntoConstraints = false
        day4OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day4OLabel)
        
        day4OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day4OText)
        
        
 
        
        day5Label.translatesAutoresizingMaskIntoConstraints = false
        day5Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day5Label)
        
        day5Text.translatesAutoresizingMaskIntoConstraints = false
        day5Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day5Text)
        
        day5OLabel.translatesAutoresizingMaskIntoConstraints = false
        day5OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day5OLabel)
        
        day5OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day5OText)
        
        
        
        
        day6Label.translatesAutoresizingMaskIntoConstraints = false
        day6Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day6Label)
        
        day6Text.translatesAutoresizingMaskIntoConstraints = false
        day6Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day6Text)
        
        day6OLabel.translatesAutoresizingMaskIntoConstraints = false
        day6OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day6OLabel)
        
        day6OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day6OText)
        
        
        
        
        day7Label.translatesAutoresizingMaskIntoConstraints = false
        day7Label.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day7Label)
        
        day7Text.translatesAutoresizingMaskIntoConstraints = false
        day7Text.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day7Text)
        
        day7OLabel.translatesAutoresizingMaskIntoConstraints = false
        day7OLabel.font = UIFont(name:"Helvetica-Bold", size:18)
        scrollView.addSubview(day7OLabel)
        
        day7OText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(day7OText)
        
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
        
//        let filterFlowLayout1 = UICollectionViewFlowLayout()
//        filterFlowLayout1.minimumLineSpacing = itemPadding
//        filterFlowLayout1.minimumInteritemSpacing = itemPadding
//        filterFlowLayout1.scrollDirection = .horizontal
//        filterFlowLayout1.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView1 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout1)
//        filterCollectionView1.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView1.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID1)
//        filterCollectionView1.dataSource = self
//        filterCollectionView1.delegate = self
//        view.addSubview(filterCollectionView1)
//        
//        let filterFlowLayout2 = UICollectionViewFlowLayout()
//        filterFlowLayout2.minimumLineSpacing = itemPadding
//        filterFlowLayout2.minimumInteritemSpacing = itemPadding
//        filterFlowLayout2.scrollDirection = .horizontal
//        filterFlowLayout2.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView2 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout2)
//        filterCollectionView2.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView2.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID2)
//        filterCollectionView2.dataSource = self
//        filterCollectionView2.delegate = self
//        view.addSubview(filterCollectionView2)
//        
//        let filterFlowLayout3 = UICollectionViewFlowLayout()
//        filterFlowLayout3.minimumLineSpacing = itemPadding
//        filterFlowLayout3.minimumInteritemSpacing = itemPadding
//        filterFlowLayout3.scrollDirection = .horizontal
//        filterFlowLayout3.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView3 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout3)
//        filterCollectionView3.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView3.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID3)
//        filterCollectionView3.dataSource = self
//        filterCollectionView3.delegate = self
//        view.addSubview(filterCollectionView3)
//        
//        let filterFlowLayout4 = UICollectionViewFlowLayout()
//        filterFlowLayout4.minimumLineSpacing = itemPadding
//        filterFlowLayout4.minimumInteritemSpacing = itemPadding
//        filterFlowLayout4.scrollDirection = .horizontal
//        filterFlowLayout4.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView4 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout4)
//        filterCollectionView4.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView4.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID4)
//        filterCollectionView4.dataSource = self
//        filterCollectionView4.delegate = self
//        view.addSubview(filterCollectionView4)
//        
//        let filterFlowLayout5 = UICollectionViewFlowLayout()
//        filterFlowLayout5.minimumLineSpacing = itemPadding
//        filterFlowLayout5.minimumInteritemSpacing = itemPadding
//        filterFlowLayout5.scrollDirection = .horizontal
//        filterFlowLayout5.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView5 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout5)
//        filterCollectionView5.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView5.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID5)
//        filterCollectionView5.dataSource = self
//        filterCollectionView5.delegate = self
//        view.addSubview(filterCollectionView5)
//        
//        let filterFlowLayout6 = UICollectionViewFlowLayout()
//        filterFlowLayout6.minimumLineSpacing = itemPadding
//        filterFlowLayout6.minimumInteritemSpacing = itemPadding
//        filterFlowLayout6.scrollDirection = .horizontal
//        filterFlowLayout6.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView6 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout6)
//        filterCollectionView6.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView6.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID6)
//        filterCollectionView6.dataSource = self
//        filterCollectionView6.delegate = self
//        view.addSubview(filterCollectionView6)
//        
//        let filterFlowLayout7 = UICollectionViewFlowLayout()
//        filterFlowLayout7.minimumLineSpacing = itemPadding
//        filterFlowLayout7.minimumInteritemSpacing = itemPadding
//        filterFlowLayout7.scrollDirection = .horizontal
//        filterFlowLayout7.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
//        
//        filterCollectionView7 = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout7)
//        filterCollectionView7.translatesAutoresizingMaskIntoConstraints = false
//        filterCollectionView7.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID7)
//        filterCollectionView7.dataSource = self
//        filterCollectionView7.delegate = self
//        view.addSubview(filterCollectionView7)
//        
//        filterCollectionView1.tag = 1
//        filterCollectionView2.tag = 2
//        filterCollectionView3.tag = 3
//        filterCollectionView4.tag = 4
//        filterCollectionView5.tag = 5
//        filterCollectionView6.tag = 6
//        filterCollectionView7.tag = 7
//        
        
        
        
        setupConstraints()
        
    }
    
    func addClothes(val1: Int, val2: Int) -> Clothes {
        return clothes[val1][val2]
}
    
    func setupConstraints() {
        let layout = view.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layout.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            intro.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            intro.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationLaebl.topAnchor.constraint(equalTo: intro.bottomAnchor, constant: 15),
            locationLaebl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationText.topAnchor.constraint(equalTo: intro.bottomAnchor, constant: 15),
            locationText.leadingAnchor.constraint(equalTo: locationLaebl.trailingAnchor, constant: 5),
            locationText.centerYAnchor.constraint(equalTo: locationLaebl.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lengthLabel.topAnchor.constraint(equalTo: locationText.bottomAnchor, constant: 15),
            lengthLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            lengthText.topAnchor.constraint(equalTo: locationText.bottomAnchor, constant: 15),
            lengthText.leadingAnchor.constraint(equalTo: lengthLabel.trailingAnchor, constant: 5),
            lengthText.centerYAnchor.constraint(equalTo: lengthLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: lengthText.bottomAnchor, constant: 15),
            goButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            goButton.widthAnchor.constraint(equalToConstant: 62),
            goButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            day1Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day1Label.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day1Text.leadingAnchor.constraint(equalTo: day1Label.trailingAnchor, constant: 10),
            day1Text.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day1OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day1OLabel.topAnchor.constraint(equalTo: day1Label.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day1OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day1OText.topAnchor.constraint(equalTo: day1OLabel.bottomAnchor, constant: 15)
        ])
        
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            day2Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day2Label.topAnchor.constraint(equalTo: day1OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day2Text.leadingAnchor.constraint(equalTo: day2Label.trailingAnchor, constant: 10),
            day2Text.topAnchor.constraint(equalTo: day1OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day2OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day2OLabel.topAnchor.constraint(equalTo: day2Label.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day2OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day2OText.topAnchor.constraint(equalTo: day2OLabel.bottomAnchor, constant: 15)
        ])
        
        
        NSLayoutConstraint.activate([
            day3Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day3Label.topAnchor.constraint(equalTo: day2OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day3Text.leadingAnchor.constraint(equalTo: day3Label.trailingAnchor, constant: 10),
            day3Text.topAnchor.constraint(equalTo: day2OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day3OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day3OLabel.topAnchor.constraint(equalTo: day3Label.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day3OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day3OText.topAnchor.constraint(equalTo: day3OLabel.bottomAnchor, constant: 15)
        ])
        
        
        NSLayoutConstraint.activate([
            day4Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day4Label.topAnchor.constraint(equalTo: day3OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day4Text.leadingAnchor.constraint(equalTo: day4Label.trailingAnchor, constant: 10),
            day4Text.topAnchor.constraint(equalTo: day3OText.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day4OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day4OLabel.topAnchor.constraint(equalTo: day4Label.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day4OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day4OText.topAnchor.constraint(equalTo: day4OLabel.bottomAnchor, constant: 15)
        ])
        

        NSLayoutConstraint.activate([
            day5Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day5Label.topAnchor.constraint(equalTo: day4OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day5Text.leadingAnchor.constraint(equalTo: day5Label.trailingAnchor, constant: 10),
            day5Text.topAnchor.constraint(equalTo: day4OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day5OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day5OLabel.topAnchor.constraint(equalTo: day5Label.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day5OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day5OText.topAnchor.constraint(equalTo: day5OLabel.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            day6Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day6Label.topAnchor.constraint(equalTo: day5OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day6Text.leadingAnchor.constraint(equalTo: day6Label.trailingAnchor, constant: 10),
            day6Text.topAnchor.constraint(equalTo: day5OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day6OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day6OLabel.topAnchor.constraint(equalTo: day6Label.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day6OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day6OText.topAnchor.constraint(equalTo: day6OLabel.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day7Label.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day7Label.topAnchor.constraint(equalTo: day6OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day7Text.leadingAnchor.constraint(equalTo: day7Label.trailingAnchor, constant: 10),
            day7Text.topAnchor.constraint(equalTo: day6OText.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day7OLabel.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day7OLabel.topAnchor.constraint(equalTo: day7Label.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            day7OText.leadingAnchor.constraint(equalTo: locationLaebl.leadingAnchor),
            day7OText.topAnchor.constraint(equalTo: day7OLabel.bottomAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -150)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        
        NSLayoutConstraint.activate([
            addClothes.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -8),
            addClothes.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
    
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
            guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
                else {
                    return nil
            }
            do {
                var contents = try String(contentsOfFile: filepath, encoding: .utf8)
                contents = cleanRows(file: contents)
                return contents
            } catch {
                print("File Read Error for file \(filepath)")
                return nil
            }
        }


    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
            var result: [[String]] = []
            let rows = data.components(separatedBy: "\n")
            for row in rows {
                let columns = row.components(separatedBy: ",")
                result.append(columns)
            }
            return result
        }
    
    
    func getCoord(from url: String)->[Int]{
        var a = [0]
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }

            var result: ResponseCoord?

            do {
                result = try JSONDecoder().decode(ResponseCoord.self, from: data)
            }
            catch{
                print("failed first one")
            }

            guard let json = result else {
                print("ruh roh ")
                return
            }
            DispatchQueue.main.async{
                a = self.getData(from: json.properties.forecast)
            }
            
            
            print("this is a \(a)")
        })

        task.resume()
        return a
    }
    
    struct ResponseCoord: Codable{
        let properties: myP
    }
    struct myP: Codable{
        let forecast: String
    }
    var temps = [Int]()
    
    func getData(from url: String)->[Int]{
       
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }

            var result: Response?

            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print(url)
            }

            guard let json = result else {
                print("ruh roh ")
                return
            }
            
            self.numDays = self.numDays * 2
            for i in stride(from: 0, to: self.numDays-1, by: 2) {
                self.temps.append(json.properties.periods[i].temperature)
            }
            //waiting = true
            pressButtonUpdate()
            
            
            
            
                        
            //self.temp = b
        //return temp
            //print(json.results.main.temp)


        })

        task.resume()
        return temps
    }
    
    struct Response: Codable{
        let properties: Prop
    }
    struct Prop: Codable{
        let periods: [Per]
    }
    struct Per: Codable{
        let temperature: Int
    }
    
    
    @objc func addClothesButt(){
        //pass in perm view controller later
        permOutfitViewController?.travelVC = true
        if (permOutfitViewController == nil){
            permOutfitViewController = OutfitViewController(inputDelegate: self)
        }
        navigationController?.pushViewController(permOutfitViewController!, animated: true)
    }
    
    
    var lat: String = ""
    var long:String = ""
    var numDays:Int = 1
    @objc func pressButton() {
        
        UserDefaults().setValue(locationText.text, forKey: "zipcodeVacay")
        UserDefaults().setValue(lengthText.text, forKey: "lenVacation")
        
        
        self.numDays = Int(lengthText.text ?? "1")!
        var data = readDataFromCSV(fileName: "uszips", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)// UXM n. 166/167
        let banana = csvRows[1][0]
        

        for i in 0...csvRows.count-1{
            if (csvRows[i][0].replacingOccurrences(of: "\"", with: "")==locationText.text){
                print("in here")
                lat = csvRows[i][1]
                long = csvRows[i][2]
                sections[0] = "Vacation in \(csvRows[i][3])"
            }
        }
        print(csvRows.count)
        print(lat)

        let concatenatedString = "https://api.weather.gov/points/" + lat + "," + long

        //read from excel or csv
        //var url = "https://api.weather.gov/points/\(lat),\(long)"

        print(concatenatedString.replacingOccurrences(of: "\"", with: ""))
        //problem is thatt here is a lot of data in this do i need to include all?


        var songNumber:[Int] = []
        
       
            songNumber = self.getCoord(from: concatenatedString.replacingOccurrences(of: "\"", with: ""))
            print("SongNumber \(songNumber)")
            print("Temps \(self.temps)")
            


        //if temp below 0 big puffer jacket several layers
        //add humidity later

        //HOW DO I GET THIS TO UPDATE AFTER THE CALL
     

        
    }
    @objc func pressButtonUpdate(){
        
        
        
        var songNumber:[Int] = []
        
        DispatchQueue.main.async {
            //            while(len(songNumber)!=0){
            //
            //            }
            //songNumber = self.getCoord(from: concatenatedString.replacingOccurrences(of: "\"", with: ""))
            print("SongNumber \(songNumber)")
            print("Temps \(self.temps)")
            
            var dayLabels = [self.day1Label,self.day2Label,self.day3Label,self.day4Label,self.day5Label,self.day6Label,self.day7Label]
            var dayTexts = [self.day1Text,self.day2Text,self.day3Text,self.day4Text,self.day5Text,self.day6Text,self.day7Text]
            var dayOLabels = [self.day1OLabel,self.day2OLabel,self.day3OLabel,self.day4OLabel,self.day5OLabel,self.day6OLabel,self.day7OLabel]
            var dayOTexts = [self.day1OText,self.day2OText,self.day3OText,self.day4OText,self.day5OText,self.day6OText,self.day7OText]
            
           
            var count = 0
            print(songNumber)
            for i in self.temps{
                print(count)
                print(i)
                dayLabels[count].text = "Day \(count+1): "
                dayLabels[count].textColor = .black
                dayTexts[count].text = "\(i)°F"
                dayOLabels[count].text = "Outfit Recommendation:"
                
                if (i<25){
                    dayOTexts[count].text = "Wear a thick winter coat with long pants. Be conscious of the heaters indoors wear layers under the coat. "
                }
                else if (i<=44){
                    dayOTexts[count].text = "Wear a light to medium coat with long pants and a tshirt underneath. "
                }
                else if (i<=64){
                    dayOTexts[count].text = "Wear a thin jacket or long sleeve shirt with pants.  "
                }
                else if (i<=79){
                    dayOTexts[count].text = "Short sleeves and shorts are acceptable \n but wear a jacket in case "
                }
                else{
                    dayOTexts[count].text = "Tank top and short weather, it is hot!"
                }
                
                dayLabels[count].translatesAutoresizingMaskIntoConstraints = false
                self.scrollView.addSubview(dayLabels[count])
                
                dayTexts[count].translatesAutoresizingMaskIntoConstraints = false
                self.scrollView.addSubview(dayTexts[count])
                
                dayOLabels[count].translatesAutoresizingMaskIntoConstraints = false
                self.scrollView.addSubview(dayOLabels[count])
                
                dayOTexts[count].translatesAutoresizingMaskIntoConstraints = false
                print(dayOTexts[count].text)
    
                self.scrollView.addSubview(dayOTexts[count])
                
                count+=1
            }
            
            self.temps = []
        }
                
    }
}
protocol vacayDelegate: UIViewController {

}

extension TravelViewController : UICollectionViewDataSource {
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

extension TravelViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
            return CGSize(width: len, height: len)
    
    }

    //MARK: Header shape code
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
       
    }
    
}

extension TravelViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.clothes[0].remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }

}














//extension TravelViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//            return filters.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if (collectionView.tag == 1){
//            if let cell = filterCollectionView1.dequeueReusableCell(withReuseIdentifier: filterCellReuseID1, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 2){
//            if let cell = filterCollectionView2.dequeueReusableCell(withReuseIdentifier: filterCellReuseID2, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 3){
//            if let cell = filterCollectionView3.dequeueReusableCell(withReuseIdentifier: filterCellReuseID3, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 4){
//            if let cell = filterCollectionView4.dequeueReusableCell(withReuseIdentifier: filterCellReuseID4, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 5){
//            if let cell = filterCollectionView5.dequeueReusableCell(withReuseIdentifier: filterCellReuseID5, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 6){
//            if let cell = filterCollectionView6.dequeueReusableCell(withReuseIdentifier: filterCellReuseID6, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//        if (collectionView.tag == 7){
//            if let cell = filterCollectionView7.dequeueReusableCell(withReuseIdentifier: filterCellReuseID7, for: indexPath) as? DisplayOutfitCollectionView {
//                let filter = filters[indexPath.row]
//                cell.configure(clothes: filter)
//                return cell
//            }
//        }
//
//
//        return UICollectionViewCell()
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//            return 1
//
//    }
//
//    //MARK: Header setup function
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        return UICollectionReusableView()
//    }
//
//}
//
//extension TravelViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
//        return CGSize(width: len, height: len)
//    }
//
//    //MARK: Header shape code
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width:0, height: 0)
//    }
//
//}
