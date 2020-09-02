//
//  Page2ViewController.swift
//  Swift5IntroApp01
//
//  Created by 中塚富士雄 on 2020/08/27.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import SegementSlide

class Page2ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    //XML Parserのインスタンスを作成する
    var parser = XMLParser()
   
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    
    var newsItems = [NewsItems]()

    override func viewDidLoad() {
        super.viewDidLoad()

     
        tableView.backgroundColor = .clear
        
        //画像をTableViewの下に置く
        let image = UIImage(named: "1")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height:self.tableView.frame.size.height))
    
            imageView.image = image
        self.tableView.backgroundView = imageView
      
        //XMLパース
        let urlString = "https://www.mhlw.go.jp/stf/news.rdf"
        let url:URL = URL(string:urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
    }
    @objc var scrollView: UIScrollView{
        
        return tableView
        
    }
    // UITableViewが持っているメソッドを使うときは、全てoverrideが付いて上書きをする⭐️

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        
        let newsItem = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        //⭐️dc:dateが拾えないので日時表示はできない
        cell.detailTextLabel?.text = newsItem.date
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
   
    
    //XML書式で書かれたものを一つ一つチェックしていく。"item"にぶつかったらNewsItems(modelで定義)を初期化する。
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            
            self.newsItems.append(NewsItems())
            
            //[a,b,c] = [title,url,pubDate]⭐️のことで良いのか？
            
        }else{
                
                currentElementName = elementName
            
            
        }
            

    
    }
   
    //判定メソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0{
            
            //配列の中身は1→5だが、順番は0→4番目なので1を入れると1番目の2になってしまう
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            
            switch self.currentElementName {
            
            
            //stringはfoundCharactersで見つけたもの。それをlastItemのtitleに入れる。
            case "title":
                lastItem.title = string
                
            case "link":
                lastItem.url = string
                
            case "pubDate":
                lastItem.pubDate = string
                
            default:break
                
            }
          
        }
      
    
    }
        // 呼ばれて一旦空にする⭐️
        func parser(_ parser:XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?){
            
            self.currentElementName = nil
        }
            //どういう瞬間に必要か？⭐️
            func parserDidEndDocument(_ parser: XMLParser){
                
                self.tableView.reloadData()
            }

                //⭐️overrideで'override' can only be specified on class membersと警告⭐️
             override func tableView(_ tableView: UITableView, didSelectRowAt IndexPath: IndexPath){
                    
                  let webViewController = WebViewController()
                webViewController.modalTransitionStyle = .crossDissolve
                let newsItem = newsItems[IndexPath.row]
                UserDefaults.standard.set(newsItem.url, forKey: "url")
                present(webViewController,animated: true, completion: nil)
                    
            }
                   
                       
                
            
            
}
    
    
    


    
    
    

