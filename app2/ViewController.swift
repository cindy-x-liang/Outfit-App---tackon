//
//  ViewController.swift
//  app2
//
//  Created by Cindy Liang on 6/4/23.
//
import UIKit
import Foundation
import TabularData
import FirebaseStorage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, saveInfoDelegate, banana, vacayDelegate{
    func addClothesItemToVC(clo: Clothes, mainVCPress: Bool, travelVCPress: Bool) {
        if (mainVCPress){
            topImage = clo
            filters.append(topImage)
            filterCollectionView.reloadData()
            permOutfitViewController?.mainVC = false
        }
    }
    

    

    
    func setName(str: String){
        if let name = UserDefaults().value(forKey:"userName") as? String{
            welcomeText.text = "welcome, \(name) "
            print("in here")
        }
        else{
            welcomeText.text = "welcome, \(str) "
            print("here")
        }
    }
//    func setLocation(str: String){
//        locationLabel.text = str
//    }
    
    func setPressed(bool:Bool){
        pressed = true
    }
    
    var filterCollectionView: UICollectionView!
    
    
    //private let storage = Storage.storage().reference()
    var topImage = Clothes(imageName:  UIImage(named: "box")!, clothesTypeEntered: "Top")
    var bottImage = ""
    var otherImage = ""
    var pressed = false
    var nameLabel = UILabel()
    var outfitLabel = UILabel()
    var locationLabel = UILabel()
    let button = UIButton()
    var location = UITextField()
    var welcomeText = UILabel()
    var temp: Int? = nil
    var outfitText = UILabel()
    var lat: String = ""
    var long:String = ""
    let buttonUpload = UIButton()
    let imageOut = UIImageView()
    let labelURL = UILabel()
    let buttGo = UIButton()
    var timeOfDay = UILabel()
    var tempDisplay = UILabel()
    var humidity = UILabel()
    var precip = UILabel()
    var windSpeed = UILabel()
    var rectangle = UIImageView()
    var yourOutfitReco = UILabel()
    
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let filterCellReuseID = "filterCellReuseID"
    
    var permOutfitViewController:OutfitViewController? = nil
    var permTravelViewController: TravelViewController? = nil
    
    let vacationMode = UIButton()
    
    private var filters = [Clothes(imageName:  UIImage(named: "top1")!, clothesTypeEntered: "Top"), Clothes(imageName:  UIImage(named: "bottom1")!, clothesTypeEntered: "Top")]
    
    let tabBarVC = UITabBarController()
//    let vc1 = ViewController()
    let vc2 = SecondViewController()
//    
//    tabBarVC.setViewControllers([vc2], animated: false)
//    tabBarVC.modalPresentationStyle = .fullScreen
//    present(tabBarVC, animated: true)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        //semaphoreName.wait()
        if Core.shared.isNewUser(){
            presentView()
//            queueName.async {
//                while(!self.pressed){
//
//                    semaphoreName.wait()
//                    sleep(30)
//                    semaphoreName.signal()
//                }
//            }
        }
        //semaphoreName.signal()
        

        let filterFlowLayout = UICollectionViewFlowLayout()
        filterFlowLayout.minimumLineSpacing = itemPadding
        filterFlowLayout.minimumInteritemSpacing = itemPadding
        filterFlowLayout.scrollDirection = .horizontal
        filterFlowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.register(DisplayOutfitCollectionView.self, forCellWithReuseIdentifier: filterCellReuseID)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        view.addSubview(filterCollectionView)
        
        
        
        //var toInsert: String = "Welcome, \(nameLabel.text) "
        //welcomeText.text = toInsert
        if let name = UserDefaults().value(forKey:"userName") as? String{
            welcomeText.text = "welcome, \(name) "
            print("in here")
        }
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        welcomeText.font = UIFont(name:"Helvetica-Bold", size:35)
        welcomeText.lineBreakMode = .byWordWrapping
        welcomeText.numberOfLines = 2
        view.addSubview(welcomeText)
        
        locationLabel.text = "location:"
        locationLabel.font = .systemFont(ofSize: 25, weight: .bold)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        
        outfitLabel.text = "build an outfit:"
        outfitLabel.font = .systemFont(ofSize: 25, weight: .bold)
        outfitLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outfitLabel)
     
        yourOutfitReco.text = ""
        yourOutfitReco.font = UIFont(name:"Helvetica-Bold", size:22)
        yourOutfitReco.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yourOutfitReco)
        
        if let zip = UserDefaults().value(forKey:"zipcodeHome") as? String{
            location.text = zip
            print("in here")
        }
        else{
            location.placeholder = "enter zip code"
        }
        
        location.placeholder = "enter zip code"
        location.font = .systemFont(ofSize: 20, weight: .bold)
        location.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(location)
        
        //buttImage = UIImage(named: "setLocationButt", size: CGSize(width: 1000, height: 1000))
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        //button.setImage(UIImage(named: "setLocationButt"), for: .normal)
        
        button.setTitle("set location ->", for: .normal)
        view.addSubview(button)

        rectangle.image = UIImage(named: "Rectangle 13")
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle)
    
        
        timeOfDay.text = ""
        timeOfDay.font = UIFont(name:"Helvetica-Bold", size:35)
        timeOfDay.translatesAutoresizingMaskIntoConstraints = false
        timeOfDay.numberOfLines = 1
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(timeOfDay)
        
        tempDisplay.text = ""
        tempDisplay.font = UIFont(name:"Helvetica-Bold", size:35)
        tempDisplay.translatesAutoresizingMaskIntoConstraints = false
        tempDisplay.numberOfLines = 1
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(tempDisplay)
        
        humidity.text = ""
        humidity.translatesAutoresizingMaskIntoConstraints = false
        humidity.numberOfLines = 7
        humidity.font = UIFont(name:"Helvetica", size:12)
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(humidity)
        
        precip.text = ""
        precip.translatesAutoresizingMaskIntoConstraints = false
        precip.numberOfLines = 2
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(precip)
        
        windSpeed.text = ""
        windSpeed.numberOfLines = 2
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(windSpeed)

        outfitText.text = ""
        outfitText.translatesAutoresizingMaskIntoConstraints = false
        outfitText.numberOfLines = 2
        //outfitText.lineBreakMode = .byCharWrapping
        view.addSubview(outfitText)
        
//
//        buttonUpload.addTarget(self, action: #selector(tapUploadButton), for: .touchUpInside)
//        buttonUpload.translatesAutoresizingMaskIntoConstraints = false
//        buttonUpload.setTitleColor(.black, for: .normal)
//        buttonUpload.setTitle("upload image", for: .normal)
//        view.addSubview(buttonUpload)
//
        buttGo.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        buttGo.translatesAutoresizingMaskIntoConstraints = false
        buttGo.setTitleColor(.black, for: .normal)
        buttGo.setTitle("wardrobe ->", for: .normal)
        view.addSubview(buttGo)
        
     
        vacationMode.addTarget(self, action: #selector(vacayView), for: .touchUpInside)
        vacationMode.translatesAutoresizingMaskIntoConstraints = false
        vacationMode.setTitleColor(.black, for: .normal)
        //vacationMode.setImage(UIImage(named: "travelicon"), for: .normal)
        view.addSubview(vacationMode)
        
        
        
//
//        imageOut.translatesAutoresizingMaskIntoConstraints = false
//        imageOut.contentMode = .scaleAspectFit
//        view.addSubview(imageOut)
//
//
//        labelURL.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelURL)
        //get the text through a networking request
        
        //calls a function to get request for weather
        //parses what the outfit should be depending on weather
        
//        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
//              let url = URL(string: urlString) else{
//            return
//        }
//        labelURL.text = urlString
//        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
//            guard let data = data, error == nil else{
//                return
//            }
//
//            DispatchQueue.main.async{
//                let image = UIImage(data: data)
//                self.imageOut.image = image
//            }
//        })
//
//        task.resume()
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            welcomeText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            welcomeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 15),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 15),
            location.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 5),
            location.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 15),
            button.centerYAnchor.constraint(equalTo: location.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 5),
            rectangle.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            rectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            //rectangle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
        
        
        
        NSLayoutConstraint.activate([
            timeOfDay.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 10),
            timeOfDay.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            tempDisplay.leadingAnchor.constraint(equalTo: timeOfDay.trailingAnchor),
            tempDisplay.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            humidity.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 10),
            humidity.topAnchor.constraint(equalTo: timeOfDay.bottomAnchor, constant: 15),
            humidity.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            yourOutfitReco.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 10),
            yourOutfitReco.topAnchor.constraint(equalTo: humidity.bottomAnchor, constant: 10)
        ])
        
        
        
        NSLayoutConstraint.activate([
            outfitText.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 10),
            outfitText.topAnchor.constraint(equalTo: yourOutfitReco.bottomAnchor),
            outfitText.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -8)
        ])
        
//        NSLayoutConstraint.activate([
//            buttonUpload.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
//            buttonUpload.topAnchor.constraint(equalTo: outfitText.bottomAnchor, constant: 15)
//        ])
        
        
        NSLayoutConstraint.activate([
            outfitLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            outfitLabel.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            buttGo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttGo.bottomAnchor.constraint(equalTo: outfitLabel.bottomAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            imageOut.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
//            imageOut.topAnchor.constraint(equalTo: buttonUpload.bottomAnchor, constant: 15),
//            imageOut.widthAnchor.constraint(equalToConstant: 350),
//            imageOut.heightAnchor.constraint(equalToConstant: 200)
//        ])
        
        
//        NSLayoutConstraint.activate([
//            labelURL.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
//            labelURL.topAnchor.constraint(equalTo: imageOut.bottomAnchor, constant: 15)
//        ])
        
        let collectionViewPadding: CGFloat = 12

        //MARK: Create Constraints for filter cell
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: buttGo.bottomAnchor, constant: -10),
            filterCollectionView.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: collectionViewPadding),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            vacationMode.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vacationMode.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 15)
        ])
        
    }
    
//    func getCSVData() -> Array<String> {
//        do {
//            let content = try String(contentsOfFile: "uszips.csv")
//            let parsedCSV: [String] = content.components(
//                separatedBy: "\n"
//            ).map{ $0.components(separatedBy: ",")[0] }
//            return parsedCSV
//        }
//        catch {
//            return []
//        }
//    }
            
    
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
    
    
    func getCoord(from url: String)->Int{
        var a = 0
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
            
            a = getData(from: json.properties.forecast)
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
    var timeOfDayText: String = ""
    var detailFore: String = ""
    func getData(from url: String)->Int{
        var b = 0
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

            
            b = (json.properties.periods[0].temperature)
            print("this is b: \(b)")

            self.temp = b
            self.timeOfDayText = json.properties.periods[0].name
            self.detailFore = json.properties.periods[0].detailedForecast
            
//            if (json.properties.periods[0].relativeHumidity.value == nil){
//                humidity.text = "0& relative humidity"
//            }else{
//                humidity.text = "\(json.properties.periods[0].relativeHumidity.value)% relative humidity"
//            }
//
//            if (json.properties.periods[0].probabilityOfPrecipitation.value == nil){
//                precip.text = "0% chance of precipitation"
//            }else{
//                precip.text = "\(json.properties.periods[0].probabilityOfPrecipitation.value)% chance of precipitation"
//            }
            
            //windSpeed.text = "\(json.properties.periods[0].windSpeed) wind speed"
            updateOutFitText()
            //self.temp = b
        //return temp
            //print(json.results.main.temp)


        })

        task.resume()
        return b
    }
    
    struct Response: Codable{
        let properties: Prop
    }
    struct Prop: Codable{
        let periods: [Per]
    }
    struct Per: Codable{
        let name: String
        let temperature: Int
//        let probabilityOfPrecipitation: precipT
//        let relativeHumidity: humid
        let windSpeed: String
        let detailedForecast: String
        
    }
//    struct precipT: Codable{
//        let value: String
//
//    }
//    struct humid: Codable{
//        let value: String
//
//    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser(){
            //let storyboard = UIStoryboard(name: "LaunchScreen.storyboard", bundle: nil)
//            let vc = storyboard?.instantiateViewController(identifier: "welcome") as! WelcomeViewController
//            //vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
        }
    }
    
    @objc func presentView() {
        present(WelcomeViewController(inputDelegate: self), animated: true, completion: nil)
    }
    
    @objc func pushView() {
        permOutfitViewController?.mainVC = true
        if (permOutfitViewController == nil){
            permOutfitViewController = OutfitViewController(inputDelegate: self)
            vacationMode.setImage(UIImage(named: "travelicon"), for: .normal)
        }
        navigationController?.pushViewController(permOutfitViewController!, animated: true)
    }
    
    
    @objc func vacayView() {
        if (permTravelViewController == nil){
            permTravelViewController = TravelViewController(inputDelegate: self)
            permTravelViewController!.permOutfitViewController = permOutfitViewController
            permOutfitViewController?.setTravelDelegate(delegate: permTravelViewController!)
        }
        
        
        navigationController?.pushViewController(permTravelViewController!, animated: true)
    }
 
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//        picker.dismiss(animated: true, completion: nil)
//        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
//            return
//        }
//        guard let imageData = image.pngData() else{
//            return
//        }
//
//        storage.child("images/files.png").putData(imageData, metadata: nil, completion: {_, error in
//            guard error == nil else{
//                print("Failed to upload")
//                return
//            }
//            self.storage.child("images/files.png").downloadURL(completion: {url, error in
//                guard let url = url, error == nil else{
//                    return
//                }
//
//                let urlString = url.absoluteString
//                DispatchQueue.main.async{
//                    self.labelURL.text = urlString
//                    self.imageOut.image = image
//                }
//
//                print("Download URL: \(urlString)")
//                UserDefaults.standard.set(urlString, forKey: "url")
//            })
//
//        })
        //upload image data
        //get download url
        //save download url to userDefaults
        
//    }

//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//
//    @objc func tapUploadButton(){
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.delegate = self
//        picker.allowsEditing = true
//        present(picker, animated: true)
//    }
    
    @objc func pressButton() {
        UserDefaults().setValue(location.text, forKey: "zipcodeHome")
        var data = readDataFromCSV(fileName: "uszips", fileType: "csv")
            data = cleanRows(file: data!)
            let csvRows = csv(data: data!)// UXM n. 166/167
        let banana = csvRows[1][0]
    
        //can take in numeric input for zipcode and subtract it from 601 to get index
        print(banana.compare("00601"))
        print(banana.isEqual("00601"))
        //string comparison isnt working
        print(csvRows[1][0])
        
        for i in 0...csvRows.count-1{
            if (csvRows[i][0].replacingOccurrences(of: "\"", with: "")==location.text){
                print("in here")
                
                lat = csvRows[i][1]
                long = csvRows[i][2]
            }
        }
        print(csvRows.count)
        print(lat)
        
        let concatenatedString = "https://api.weather.gov/points/" + lat + "," + long
       
        
        
        //read from excel or csv
        //var url = "https://api.weather.gov/points/\(lat),\(long)"
        var url = concatenatedString

        print(concatenatedString.replacingOccurrences(of: "\"", with: ""))
        //problem is thatt here is a lot of data in this do i need to include all?
        
       
        //DispatchQueue.main.async {
            let songNumber = self.getCoord(from: concatenatedString.replacingOccurrences(of: "\"", with: ""))
            print("this is songNumber \(songNumber)")
            self.temp = songNumber
            
            print("this is self.temp \(self.temp)")
            
            //if temp below 0 big puffer jacket several layers
            //add humidity later
            
            //HOW DO I GET THIS TO UPDATE AFTER THE CALL
        
            
            
            
            print("this is self.temp \(self.temp)")
            
            //if temp below 0 big puffer jacket several layers
            //add humidity later

        //}
    }

    @objc func updateOutFitText() {
        DispatchQueue.main.async {
            
            //HOW DO I GET THIS TO UPDATE AFTER THE CALL
            if (self.temp!<25){
                self.outfitText.text = "Wear a thick winter coat with long pants. Be conscious of the heaters indoors wear layers under the coat. "
            }
            else if (self.temp!<=44){
                self.outfitText.text = "Wear a light to medium coat with long pants and a tshirt underneath. "
            }
            else if (self.temp!<=64){
                self.outfitText.text = "Wear a thin jacket or long sleeve shirt with pants.  "
            }
            else if (self.temp!<=79){
                self.outfitText.text = "Short sleeves and shorts are acceptable \n but wear a jacket in case "
            }
            else{
                self.outfitText.text = "Tank top and short weather, it is hot!"
            }
            
            self.timeOfDay.text = self.timeOfDayText
            self.tempDisplay.text = ", \(self.temp ?? 0)°F"
            self.humidity.text = self.detailFore
            self.yourOutfitReco.text = "Your Outfit Recommendation:"
            
            self.outfitText.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.outfitText)
            
            self.timeOfDay.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.timeOfDay)
            
            self.tempDisplay.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.tempDisplay)
            
            self.humidity.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.humidity)
            
            self.yourOutfitReco.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.yourOutfitReco)
            
            self.windSpeed.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.windSpeed)
            
    
            
            
        }
    }

}


class Core{
    static let shared = Core()
    
    func isNewUser() -> Bool{
        //return true
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
                if let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseID, for: indexPath) as? DisplayOutfitCollectionView {
                    let filter = filters[indexPath.row]
                    cell.configure(clothes: filter)
                    return cell
    

        }

        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            return 1
        
    }

    //MARK: Header setup function
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        return UICollectionReusableView()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
        return CGSize(width: len, height: len)
    }

    //MARK: Header shape code
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.filters.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
    
}



