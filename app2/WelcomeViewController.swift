//
//  WelcomeViewController.swift
//  app2
//
//  Created by Cindy Liang on 6/4/23.
//
import UIKit

class WelcomeViewController: UIViewController {
    //@IBOutlet var holderView: UIView!
    //let scrollView = UIScrollView()
    
    let nameText = UITextField()
    //let locationText = UITextField()
    let nameLabel = UILabel()
    //let locationLabel = UILabel()
    let welcomeLabe = UILabel()
    let button = UIButton()
    let image1 = UIImageView()
    let image2 = UIImageView()
    let image3 = UIImageView()
    let image4 = UIImageView()
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    weak var delegate: saveInfoDelegate?

    //input your zipcode to get an outfit recommendaiton based on the weather
    //select clothes for your outfit through wardrobe
    //add pictures of clothes to your wardrobe
    //click airplane icon to plan outfits for travel as well
    init(inputDelegate: saveInfoDelegate) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        welcomeLabe.text = "welcome to tackon ✧ ೃ༄*"
        welcomeLabe.font = .systemFont(ofSize: 25, weight: .bold)
        welcomeLabe.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabe)
        
        nameLabel.text = "name: "
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameText.placeholder = "enter name"
        nameText.font = .systemFont(ofSize: 20, weight: .bold)
        nameText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameText)
        
//        locationLabel.text = "Location"
//        locationLabel.font = .systemFont(ofSize: 25, weight: .bold)
//        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(locationLabel)
//
//        locationText.text = "Enter your zip code"
//        locationText.font = .systemFont(ofSize: 20, weight: .bold)
//        locationText.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(locationText)
        
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("continue ->", for: .normal)
        view.addSubview(button)
        
        image1.image = UIImage(named: "image1")
        image1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image1)
        
        image2.image = UIImage(named: "image2")
        image2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image2)
        
        image3.image = UIImage(named: "image3")
        image3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image3)
        
        image4.image = UIImage(named: "image4")
        image4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image4)
        
        label1.text = "input your zipcode to get an outfit recommendation based on the weather"
        label1.numberOfLines = 3
        label1.font = .systemFont(ofSize: 15, weight: .regular)
        label1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label1)
        
        label2.text = "select clothes for your outfit through wardrobe"
        label2.numberOfLines = 3
        label2.font = .systemFont(ofSize: 15, weight: .regular)
        label2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label2)
        
        label3.text = "add pictures of clothes to your wardrobe"
        label3.numberOfLines = 3
        label3.font = .systemFont(ofSize: 15, weight: .regular)
        label3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label3)
        
        label4.text = "click airplane icon on the main page to plan outfits for travel as well"
        label4.numberOfLines = 3
        label4.font = .systemFont(ofSize: 15, weight: .regular)
        label4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label4)
        
        
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeLabe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: welcomeLabe.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: welcomeLabe.bottomAnchor, constant: 15),
            nameText.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15)
        ])
        
//        NSLayoutConstraint.activate([
//            locationLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 15),
//            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
//        ])
//
//        NSLayoutConstraint.activate([
//            locationText.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
//            locationText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
//        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            image1.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15),
            image1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -50),
            image1.widthAnchor.constraint(equalToConstant: 100),
            image1.heightAnchor.constraint(equalToConstant: 217)
        ])
        
        NSLayoutConstraint.activate([
            image2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15),
            image2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 50),
            image2.widthAnchor.constraint(equalToConstant: 100),
            image2.heightAnchor.constraint(equalToConstant: 217)
        ])
        
        NSLayoutConstraint.activate([
            label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            label1.topAnchor.constraint(equalTo: image1.bottomAnchor, constant: 15),
            label1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: image1.bottomAnchor, constant: 15),
            label2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 20),
            label2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            image3.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 15),
            image3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -50),
            image3.widthAnchor.constraint(equalToConstant: 100),
            image3.heightAnchor.constraint(equalToConstant: 217)
        ])
        
        
        NSLayoutConstraint.activate([
            image4.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 15),
            image4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 50),
            image4.widthAnchor.constraint(equalToConstant: 100),
            image4.heightAnchor.constraint(equalToConstant: 217)
        ])
        
        NSLayoutConstraint.activate([
            label3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            label3.topAnchor.constraint(equalTo: image3.bottomAnchor, constant: 15),
            label3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            label4.topAnchor.constraint(equalTo: image3.bottomAnchor, constant: 15),
            label4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 20),
            label4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        
        
        
        
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        configure()
//    }
//    private func configure(){
//        //set up scroll view
//        scrollView.frame = holderView.bounds
//        holderView.addSubview(scrollView)
//
//        let titles = ["Welcome","Location", "All Set"]
//        for x in 0..<3 {
//            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width),y:0, width: holderView.frame.size.width, height: holderView.frame.size.height))
//
//            scrollView.addSubview(pageView)
//
//            let label = UILabel(frame: CGRect(x:10, y:10, width:pageView.frame.size.width-20,height: 120 ))
//
//            let imageView = UIImageView(frame: CGRect(x:10, y:140, width:pageView.frame.size.width-20,height: pageView.frame.size.height - 60 - 130 - 15 ))
//
//            let button = UIButton(frame: CGRect(x:10, y:pageView.frame.size.height-60, width:pageView.frame.size.width-20,height: 50 ))
//            nameText.frame = CGRect(x:10, y:10, width:pageView.frame.size.width-20,height: 15 )
//            nameText.text = "Enter Name"
//
//            locationText.frame = CGRect(x:10, y:30, width:pageView.frame.size.width-20,height: 150 )
//            locationText.text = "Enter Location"
//
//            if (x==0){
//                pageView.addSubview(nameText)
//                pageView.addSubview(locationText)
//
//            }
//
//            label.textAlignment = .center
//            label.font = UIFont(name:"Helvetica-Bold", size:32)
//            pageView.addSubview(label)
//            label.text = titles[x]
//
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = UIImage(named: "welcome\(x+1)")
//            pageView.addSubview(imageView)
//
//            button.setTitleColor(.white, for: .normal)
//            button.backgroundColor = .black
//            button.setTitle("Continue", for: .normal)
//            if x == 2{
//                button.setTitle("Get Started", for: .normal)
//            }
//            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
//            button.tag = x+1
//            pageView.addSubview(button)
//        }
//        scrollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
//        scrollView.isPagingEnabled = true
//
//    }
    
    @objc func didTapButton(_ button: UIButton){
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
        
            UserDefaults().setValue(nameText.text, forKey: "userName")
            
            if let a = nameText.text{
                delegate?.setName(str: a)

            }
//            if let b = locationText.text {
//                delegate?.setLocation(str: b)
//
//            }
            
        delegate?.setPressed(bool: true)
        
            return
        //scroll to next page
//        scrollView.setContentOffset(CGPoint(x:holderView.frame.size.width * CGFloat(button.tag), y:0), animated: true)
        
        
        
    }
}

protocol saveInfoDelegate: UIViewController {
    func setName(str: String)
    //func setLocation(str: String)
    func setPressed(bool: Bool)
}
