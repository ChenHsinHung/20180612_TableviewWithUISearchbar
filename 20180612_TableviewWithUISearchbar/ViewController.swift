//
//  ViewController.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2018/6/12.
//  Copyright © 2018年 chen hsin hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate,UISearchBarDelegate{
    
    struct PropertyKeys {
        static let xibName = "mydefineCell"
        static let mydefineCellID001 = "mydefineCellID"
    }
   

    struct ItemcollectionPropertyKeys {
        static let xibName = "itemCollectionViewCell"
        static let cellid001 = "CollCellID"
    }

    
    @IBOutlet weak var heroTableview: UITableView!
    @IBOutlet weak var heroSearchBar: UISearchBar!
    @IBOutlet weak var herosCollectionview: UICollectionView!
    
    var isSearching = false
    
    var selectHero : HeroDataInfo?
    
    var heros : [HeroDataInfo] = [
        HeroDataInfo(name:"鋼鐵人-IronMan",voteCount : 0 , imageName: "ironman"),
        HeroDataInfo(name:"索爾-thor",voteCount : 0,imageName:"thor"),
        HeroDataInfo(name:"洛基-loki",voteCount : 0,imageName:"loki"),
        HeroDataInfo(name:"海姆達爾",voteCount : 0,imageName:"thor"),
        HeroDataInfo(name:"綠巨人浩克-Hulk",voteCount : 0,imageName:"thor"),
        HeroDataInfo(name:"黑豹",voteCount : 0,imageName:"BP"),
        HeroDataInfo(name:"美國隊長-AM-CPT-2019",voteCount : 0,imageName:"amcpt"),
        HeroDataInfo(name:"蟻人",voteCount : 0,imageName:"AntMan" ),
        HeroDataInfo(name:"黃蜂女",voteCount : 0,imageName: "thor"),
        HeroDataInfo(name:"奇異博士",voteCount : 0,imageName: "Strong")
    ]

    let superHeroData = ["鋼鐵人-IronMan","索爾-thor","洛基-loki","海姆達爾","綠巨人浩克-Hulk","黑豹","美國隊長-AM-CPT-2019","蟻人","黃蜂女","鷹眼","緋紅女巫","黑寡婦","獵鷹","星爵-StarLord","葛摩菈","火箭浣熊","格魯特-groot","德克斯"]
    
    
    var filtereData : [String]? = [String]()

    var currentviewtype : ViewType = .TableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        heroTableview.delegate = self
        heroTableview.dataSource = self
    
        //cell 採用外部註冊模式
        let nib = UINib.init(nibName: PropertyKeys.xibName, bundle: nil)
        heroTableview.register(nib, forCellReuseIdentifier: PropertyKeys.mydefineCellID001)
        
        
        //heroSearchBar.delegate = self;
        
//      heroSearchBar.returnKeyType = UIReturnKeyType.done
        

        navigationItem.title = "Avengers Endgame List"
        
        setCollectionview()
        
      


    }
    
    
    private func setCollectionview(){
        
        herosCollectionview.delegate = self
        herosCollectionview.dataSource = self
        
        //cell 採用外部註冊模式
        let nib = UINib.init(nibName: ItemcollectionPropertyKeys.xibName  , bundle: nil)
        herosCollectionview.register(nib, forCellWithReuseIdentifier: ItemcollectionPropertyKeys.cellid001)
        
        let itemsize = (UIScreen.main.bounds.width - 20) / 3  //
        //        let itemsize = (UIScreen.main.bounds.width / 3) - 10  //
        
        let flowlayout = UICollectionViewFlowLayout()
        
        flowlayout.scrollDirection = .vertical
        
        flowlayout.itemSize = CGSize(width: itemsize, height: itemsize )
        
        flowlayout.sectionInset = UIEdgeInsets.init(top: 20 ,left: 0,bottom: 10,right: 0)
        
        flowlayout.minimumInteritemSpacing = 3
        flowlayout.minimumLineSpacing =  3
        
        herosCollectionview.collectionViewLayout = flowlayout
        
    }
    
    @IBAction func toggle(_ sender: Any) {
        
        if currentviewtype == .TableView {
            heroTableview.alpha = 0
            herosCollectionview.alpha = 1
        } else {
            heroTableview.alpha = 1
            herosCollectionview.alpha = 0
            
        }
    
        currentviewtype.toggle()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            heros.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if isSearching {
            return filtereData!.count
        } else{
            
          //  return superHeroData.count
            return heros.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //自定義 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.mydefineCellID001) as! mydefineCell
 
        cell.setCellData(value: heros[indexPath.item])  //數據交給 cell 方法去處理
        cell.delegate = self
    
   
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! heroTableViewCell
 
       // cell.assginCelldata(value: heros[indexPath.item])  // 數據交給 cell 方法去處理
//        cell.delegate = self
        
    
        return cell
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "fullimage_segue" {
            let resultsViewController = segue.destination as! fullImageviewViewController
            
            resultsViewController.herodata = self.selectHero //傳遞資料
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: "showDetailSegue", sender: indexPath.row)
        print(" didSelectRowAt")
    }
    
    

    //MARK:- UISearchbar delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
      //
        filtereData = superHeroData.filter({ (names : String) -> Bool in
            return names.lowercased().range(of: searchText.lowercased()) != nil
//            return names.lowercased().contains(searchText.lowercased())
        })
        
  
        
        if searchText != "" {
            isSearching = true
            heroTableview.reloadData()
            
        } else {
            isSearching = false
            self.heroTableview.reloadData()
        }
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.isSearching = true;
        
        print("searchBarTextDidBeginEditing")
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false;
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false;
         print("searchBarCancelButtonClicked")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false;
        print("searchBarSearchButtonClicked")
        
    }

}



// MARK:- 代理實作

extension ViewController : cellEventDelegate {

    func showimage(sender : HeroDataInfo ){
        
        selectHero = sender   // get herodata
        performSegue(withIdentifier: SegueID.fullImage , sender: sender)
    }
    
    func updateVoteCount(cellForRowAt indexPath: IndexPath , value: HeroDataInfo) {
        self.heros[indexPath.item] = value
    }
    

}

// MARK:-  UIcollectionview 處理區
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemcollectionPropertyKeys.cellid001, for: indexPath) as! itemCollectionViewCell
        cell.setCellData(value: heros[indexPath.item])
        
        return cell
    }
    
    
}
